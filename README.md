[![Ruby](https://github.com/nvoynov/dogen/actions/workflows/main.yml/badge.svg)](https://github.com/nvoynov/dogen/actions/workflows/main.yml)
# Dogen

Welcome to the Dogen! It develops the ideas inherent in [Cleon](https://github.com/nvoynov/cleon) and allows you to generate more advanced code skeletons based on a domain model.

## Overview

Basically, Cleon brings structure of services, entities, and gets the ability to create skeletons of these abstractions. But what happens when we shape it into a model, and what such model can bring us?

For a while I was brooding over some source code generators and finished with something similar to following and then develop the idea further in [demo_domain.dogen](https://github.com/nvoynov/dogen/blob/master/lib/erb/demo_domain.dogen) that serves as an example of [User Domain](https://github.com/nvoynov/cleon-users).

```ruby
Model.build do
  type :string
  type :integer
  type :email

  entity :user do
    prop :name, :type => :string
    Cogen :email, :type => :email
  end

  service :register do
    para :name, :type => :string
    para :email, :type => :email
    para :secred, :type => :string
    result :user
  end
end
```

Having Dogen, one can build a domain model using provided DSL, and then create the model skeleton code. The result will be just a bit more advanced than generated by Cleon. Basically, it will utilize types. But it is better to look at the generated code right away than deep into explanations. Just install the gem and generate code for provided sample.

    $ dogen $ample
    $ dogen model/demo_domain.dogen

This will create the sample and generate the sample skeleton.

### Some statistic

Just for fun, having developed [User Domain](https://github.com/nvoynov/cleon-users), I've got some statistics about code handwritten and generated by Dogen.

Line Type | Dogen | Users
--------- | ----- | -----
Code      | 248   | 497
Empty     | 74    | 124
Comments  | 222   | 102

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dogen', '0.3.0', git: 'https://github.com/nvoynov/dogen'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ git clone https://github.com/nvoynov/dogen
    $ cd dogen
    $ rake install

## Usage

### Get help

    $ dogen

### Get sample domain

    $ dogen $ample

### Generate skeleton

    $ dogen MODEL

### Adding Cleon

Dogen just generates the source code for the model expressed by DSL. But it does not provide the core concepts that this code builds upon - `service.rb` and `entity.rb`. Therefore to get full-fledged source code that will be interpreted by Ruby, one needs to provide those concepts. I'm just cloning Cleon at this point to provide the whole core structure by `$ cleon clone`. So, my full flow is:

1. Creating DSL for a new domain and getting the DSL interpreted with no errors.
2. Creating a new gem for this new domain.
3. Cloning Cleon to the gem
4. Generating source code by Dogen.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dogen.
