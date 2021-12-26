## [Unreleased]

TODO

- [*] Generate `dogen.rb` wich requires all generated code
- [*] Reach its successful execution by `ruby -e "..."`
- [*] Combine ArGuards in one file, definition and guards
- [*] GitHub
- [*] Check if file exists already, rewrite or not
- [*] Write Yard-style comments
- [ ] Combine with Cleon (ArgCheck to ArGuard) it must not overwrite original services and entities
- [ ] tests ensure that it does not overwrite changed files
- [ ] Error handlers
- [ ] helpers Dogen.dsl, Dogen.read, Dogen.generate ...
- [ ] Generate tests for services, if it is a gem?, one test per one result
- [ ] Try entities as service and entities parameters!
- [ ] Prepare playground (Rake Cleon Dogen)

- inc file to require_relative 'dogen_<domain>', point out for rails developers? but maybe if one have test coverage it is not so important? but it is important there because it helps to find error
- push to GitHub ... maybe after next?

- to think about types one more time, and ruby 3 rbs ... maybe then contact with Viktor about tests? but it is just about pushing wrong agruments :)

- help generators for api? ala swagger?
- playground for newcomers - before API!
  - "users" domain
  - gem command to copy "users" and play
  - players readme
  - Rakefile


## [0.1.1] - 2021-12-26

- Changed `arguards.rb` and now it combines ArGuard and all guards of the model
- Generator improved. Before file writing it checks if a file with the same name exist. When it is exists, the file content checks for content changes. If there are no changes - it just skipped; conversely it assumes that the file content was changed by hands intentionally and creates __TODO__ what mark?
- Generator improved. Now it describe parameters in Yard-like way for entities and services; also attr_readers in entities.

## [0.1.0] - 2021-12-23

- Initial release
