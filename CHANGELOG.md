## [Unreleased]

it generates, but no compile at the moment ... something with arguard, try by hand .. but it require "cli"

dog
doc/users.rb  
lib
lib/users
lib/users.rb
test

$ dogen mod/users.rb - reads the model and generate, it's only destity to generate!

TODO

- [ ] Cleon should have option to clone with using Guards, because it damn convenient to have `cleon service register_user name email --advanced`
- [ ] Refactor Cleon::Generator based on Dogen::Generator
- [ ] helpers Dogen.dsl, Dogen.read, Dogen.generate ... rather Rakefile?
- [ ] Error handlers
- [ ] Generate tests for services, if it is a gem?, one test per one result
- [ ] Try entities as service and entities parameters!
- [ ] Prepare playground (Rake Cleon Dogen)
- [ ] Sinatra API generator
- [ ] Client library generator for Sinatra API

## [0.2.0] - 2021-12-26

- Changed `arguards.rb` and now it combines ArGuard and all guards of the model
- Generator improved. Now it describe parameters in Yard-like way for entities and services; also attr_readers in entities.
- Generator improved. The generator adds md5(content) in the banner. When it bumps into a file that already exists, it checks if the content was changed from the previous generation session. When the content was changed, instead of rewriting the file, it creates `.rb~` file instead of `.rb` and logs this event.

## [0.1.0] - 2021-12-23

- Initial release
