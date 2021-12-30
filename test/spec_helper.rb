# frozen_string_literal: true
require 'simplecov'
# SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "dogen"
include Dogen

require "minitest/autorun"

class Sandbox
  def self.call
    Dir.mktmpdir(['dogen']) do |dir|
      Dir.chdir(dir) { yield }
    end
  end
end

class SpecTemp
  def self.call
    Dir.mktmpdir(['dogen']) do |dir|
      Dir.chdir(dir) { yield }
    end
  end
end

class SpecGem
  def self.call(root, print_glob = false)
    SpecTemp.() do
      dirs = ['lib', "lib/#{root}", "test"]
      files = ["#{root}.gemspec", "lib/#{root}.rb",
        "lib/#{root}/version.rb", "test/spec_helper.rb"]

      dirs.each{|dir| Dir.mkdir(dir) }
      files.each{|src| File.write(src, '')}

      pp Dir.glob('**/*') if print_glob

      yield
    end
  end
end
