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
