# Change log

All notable changes to the project will be documented in this file. This project adheres to [Semantic Versioning](http://semver.org).

## [1.1.0] - 2021-10-07
### Added:
- New option `predis_options` allows setting of any options supported by Predis. Previously, the only way to use extended capabilities of Predis was to create your own Predis client instance and pass it in `predis_client`. ([#7](https://github.com/launchdarkly/php-server-sdk-redis-predis/issues/7))

## [1.0.0] - 2021-08-06
Initial release, for use with version 4.x of the LaunchDarkly PHP SDK.

