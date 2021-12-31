## [Unreleased]


TODO

вычистить от необходимости иметь структуру вообще!!!!!!!!
проверить один раз, что если есть структура немного иной журнал

- [ ] Remove MetaGem, we dont need .gemspec its about Cleon
- [ ] Release and get Rubygem badge!
- [ ] Add more tests for CLI
- [ ] Report about the work done - number of files, loc, comments, etc.
- [ ] Explore possible DSL errors Error handlers
- [ ] Try entities as service and entities parameters!
- [ ] Sinatra API generator
- [ ] Client library generator for Sinatra API

## [0.3.0] - 2021-12-31

- Updated dependencies, Cleon ~> 0.4.0
- Changed generator behavior. Now it does not require Cleon, but recommend.
- Added basic tests for CLI with rake install SETUP

## [0.2.0] - 2021-12-26

- Changed `arguards.rb` and now it combines ArGuard and all guards of the model
- Generator improved. Now it describe parameters in Yard-like way for entities and services; also attr_readers in entities.
- Generator improved. The generator adds md5(content) in the banner. When it bumps into a file that already exists, it checks if the content was changed from the previous generation session. When the content was changed, instead of rewriting the file, it creates `.rb~` file instead of `.rb` and logs this event.

## [0.1.0] - 2021-12-23

- Initial release
