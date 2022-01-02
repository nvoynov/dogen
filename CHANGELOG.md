## [Unreleased]

TODO

- [ ] rename to Dagen? Cogen Cleon
- [ ] backup `source.rb~` to `source.rb~~`?
- [ ] Tracking changes. When generated file exist, should it be replaced if its content have not changed manually? When file was changed just print "skipped because it was changed manually"
- [ ] Rename to Dagen for rubygems? Release and get the badge?
- [ ] Try entities as service and entities parameters!
- [ ] Sinatra API generator
- [ ] Client library generator for Sinatra API

- Improved Decorator, removed Cleon dependency.
- Added DSLReader that shows some errors in DSL.
- Dogen streamer changed; only MD5 calculated, no date, no model
- DSL changed: `property (prop)` for `entity`; `parameter (para)`, `result` for `service`.
- Fixed GitHub build.

## [0.3.0] - 2021-12-31

- Updated dependencies, Cleon ~> 0.4.0 (only Cleon::Decor is used now)
- Changed generator behavior. Now it does not require Cleon, but recommend.
- Added basic tests for CLI with rake install SETUP

## [0.2.0] - 2021-12-26

- Changed `arguards.rb` and now it combines ArGuard and all guards of the model
- Generator improved. Now it describe parameters in Yard-like way for entities and services; also attr_readers in entities.
- Generator improved. The generator adds md5(content) in the banner. When it bumps into a file that already exists, it checks if the content was changed from the previous generation session. When the content was changed, instead of rewriting the file, it creates `.rb~` file instead of `.rb` and logs this event.

## [0.1.0] - 2021-12-23

- Initial release
