# Dogen

UNDER CONSTRUCTION

Welcome to the Domain Generator (Dogen for simplicity), created for the glory of the [Cleon](https://github.com/nvoynov/cleon).

Cleon's way can seem quite cumbersome and time-consuming, and the most boring part there is creating and requiring files (entities, services). It's time to throw away this boredom and bring back freedom from the framework with generators.

There is part of the [Users Domain](https://github.com/nvoynov/cleon-users) expressed through Dogen DSL. The full version can be found [here](__TODO__)

```ruby
DSL.build do
  name 'Users'
  desc 'Users Management (Cleon)'

  type :five_or_more, 'integer',
    errm: 'must be Integer >= 5',
    spec: 'v.is_a?(Integer) && v >= 5'

  type :password, 'password',
    errm: 'must be String[8,50]',
    spec: 'v.is_a?(String) && v.length.between?(8, 50)'

  # just skipped ...

  entity :credentials do
    atrb :email, 'email used as login', type: :email
    atrb :password, 'password', type: :password
  end

  entity :user do
    atrb :uid, 'unique user identifier', type: :uuid, default: nil
    atrb :name, 'name', type: :user_name
    atrb :email, 'email', type: :email
  end

  service :register_user do
    param :name, 'name', type: :user_name
    param :email, 'email', type: :email
    param :password, 'password', type: :password
    result :user, 'registered user', type: :user
  end

  # jsut skipped ...
end
Gen.(dom)
```

Have the code executed, one can get a Ruby skeleton of described domain source files with arguments guard, entities, and services. The domain's type system will be used in entities and services for checking arguments.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dogen'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dogen

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dogen.
