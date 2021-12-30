# frozen_string_literal: true

require_relative "lib/dogen/version"

Gem::Specification.new do |spec|
  spec.name          = "dogen"
  spec.version       = Dogen::VERSION
  spec.authors       = ["Nikolay Voynov"]
  spec.email         = ["nvoynov@gmail.com"]

  spec.summary       = "Dogen is Domain Code Generator"
  spec.description   = <<~EOF
    Use provied DSL to describe Domain model,
    create the domain skeleton by Dogen::Gen
  EOF

  spec.homepage      = "https://github.com/nvoynov/dogen"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "cleon", "~> 0.3.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
