require 'erb'
require_relative 'decorator'

module Dogen

  # Generator that renders objects by Erb template
  #
  # @example
  #   erb = '<%= @object.to_s %>'
  #   Gen.(1, erb)
  #   # => ['1']
  #
  #   ary = [1, 2, 3]
  #   Gen.(ary, erb)
  #   # => ['1', '2', '3']
  class Render
    def self.call(obj, erb)
      new(obj, erb).call
    end

    def initialize(obj, erb)
      # @erb = ERB.new(erb, nil, "-")
      @erb = ERB.new(erb, trim_mode: '-')
      @obj = obj
      @decorator = Decorator
    end

    # Renders @obj according to @erb
    # @return [Array<String>] rendered @obj
    def call
      @obj = [@obj] unless @obj.is_a?(Enumerable)
      @obj.map{|i| render(i)}
    end

    def render(obj)
      @object = obj
      @erb.result(binding)
    end
  end

end
