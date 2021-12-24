# Dogen

UNDER CONSTRUCTION

Welcome to the Domain Generator (Dogen for simplicity), created for the glory of the [Cleon](https://github.com/nvoynov/cleon).

Cleon's way can seem quite cumbersome and time-consuming, and the most boring part there is creating and requiring files (entities, services). It's time to throw away this boredom and bring back freedom from the framework with generators.

```ruby
dom = DSL.build do
  name 'spec'
  desc 'Spec Domain'

  type :string, 'just String', errm: 'must be string',
    spec: 'v.is_a?(String)'

  entity :user do
    atrb 'member', :type => :string
    atrb 'email', :type => :string
  end

  service :register_user do
    param 'email', type: :string
    param 'password', :type => :string
    result 'user', :type => :string
  end

  # staggering zone
  url 'register_user', service: :register_user
  lib 'register_user', service: :register_user
end
Gen.(dom)
```

Have the code executed, one can get your domain skeleton of types, entities, and services. The domain's type system will be used in entities and services for checking arguments.

TODO: create [Users Domain](https://github.com/nvoynov/cleon-users) as an example and place under lib/examples. Seeing "Users Domain" code imagine that all entities and services code was just generated and only staff you should write - body of `serice#call` methods

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
