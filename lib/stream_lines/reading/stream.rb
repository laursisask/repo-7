# frozen_string_literal: true

require 'down'
require 'stream_lines/error'

module StreamLines
  module Reading
    class Stream
      include Enumerable

      def initialize(url, encoding: Encoding.default_external, chunk_size: nil, read_timeout: 90)
        @url = url
        @encoding = encoding
        @buffer = String.new(encoding: @encoding)
        @from_offset = 0
        @chunk_size = chunk_size || 1024 * 1000 * 1 # 1 Mb chunks
        @read_timeout = read_timeout
      end

      def each(&block)
        stream_lines(&block)
      end

      private

      attr_reader :url

      def stream_lines(&block)
        retries = 0
        max_retries = 8

        begin
          remote_file = Down.open(url,
            read_timeout: @read_timeout,
            rewindable: false,
            headers: { "Range" => "bytes=#{@from_offset * @chunk_size}-" }
          )

          until remote_file.eof?
            chunk = remote_file.read(@chunk_size)
            lines = extract_lines(chunk)
            lines.each { |line| block.call(line) }
            @from_offset += 1
          end

          remote_file.close
          block.call(@buffer) if @buffer.size.positive?

        rescue Down::ConnectionError, Down::TimeoutError, Down::ServerError, Down::SSLError => e
          raise Exception, "Giving up after #{retries} retries: #{e}" unless retries <= max_retries

          sleep(2**retries)
          retries += 1
          retry
        ensure
          remote_file&.close
        end
      end

      def extract_lines(chunk)
        encoded_chunk = @buffer + chunk.to_s.dup.force_encoding(@encoding)
        lines = split_lines(encoded_chunk)
        @buffer = String.new(encoding: @encoding)
        @buffer << lines.pop.to_s
        lines
      end

      def split_lines(encoded_chunk)
        encoded_chunk.split($INPUT_RECORD_SEPARATOR, -1)
      rescue ArgumentError => e
        raise e unless /invalid byte sequence/.match?(e.message)

        # NOTE: (jdlubrano)
        # The last byte in the chunk is most likely a part of a multibyte
        # character that, on its own, is an invalid byte sequence.  So, we
        # want to split the lines containing all valid bytes and make the
        # trailing bytes the last line.  The last line eventually gets added
        # to the buffer, prepended to the next chunk, and, hopefully, restores
        # a valid byte sequence.
        last_newline_index = encoded_chunk.rindex($INPUT_RECORD_SEPARATOR)
        return [encoded_chunk] if last_newline_index.nil?

        valid_lines = encoded_chunk[0...last_newline_index].split($INPUT_RECORD_SEPARATOR, -1)
        valid_lines + [encoded_chunk[(last_newline_index + 1)..-1]].compact
      end
    end
  end
end