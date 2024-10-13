# Change log

All notable changes to the project will be documented in this file. This project adheres to [Semantic Versioning](http://semver.org).

## [1.3.1](https://github.com/laursisask/repo-7/compare/v1.3.0...1.3.1) (2024-10-13)


### Miscellaneous Chores

* Update CODEOWNERS ([#19](https://github.com/laursisask/repo-7/issues/19)) ([ff74761](https://github.com/laursisask/repo-7/commit/ff74761206b5f625261bab465e8a3e5e0b5d3268))

## [1.3.0] - 2023-10-25
### Changed:
- Expanded SDK version support to v6

## [1.2.1] - 2023-01-25
### Fixed:
- Fixed compatibility error with PHP SDK 5.x branch.

## [1.2.0] - 2022-12-23
### Changed:
- The package now allows using Predis 2.x. There are no differences in the parameters unless you are using the `predis_options` parameter to pass custom options directly to Predis, in which case you should use whichever options are valid for the Predis version you are using. ([#12](https://github.com/launchdarkly/php-server-sdk-redis-predis/issues/12))
- Also changed the SDK compatibility constraint to support the upcoming 5.0.0 SDK release.

## [1.1.0] - 2021-10-07
### Added:
- New option `predis_options` allows setting of any options supported by Predis. Previously, the only way to use extended capabilities of Predis was to create your own Predis client instance and pass it in `predis_client`. ([#7](https://github.com/launchdarkly/php-server-sdk-redis-predis/issues/7))

## [1.0.0] - 2021-08-06
Initial release, for use with version 4.x of the LaunchDarkly PHP SDK.
