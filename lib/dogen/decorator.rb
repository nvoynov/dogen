require 'delegate'

module Dogen

  # Genral decorator for the domain classes
  class Decorator < SimpleDelegator
    attr_reader :root

    def initialize(object, root = '')
      super(object)
      @root = root
    end

    def name
      super.to_s
    end

    # @return ruby const from @name
    def const
      constanize(name)
    end

    def root_const
      constanize(root)
    end

    # @return [String] source file name
    def source
      "#{sanitize(name)}.rb"
    end

    # @return [String] spec file name
    def spec
      "#{sanitize(name)}_spec.rb"
    end

    # @return [String] usual ruby source file name
    def sanitize(str)
      str.downcase.strip.gsub(/\s{1,}/, '_')
    end

    # @return [String] usual ruby constant for clases
    def constanize(str)
      sanitize(str).split(?_).map(&:capitalize).join
    end

    # @return [String] of attribues
    def attributes
      retrun '' if params.empty?
      params.map{|a|
        <<~EOF
          # #{a.desc}
          attr_reader :#{a.name}
        EOF
      }.join(?\n) + "\n"
    end

    # @return [String] string of arguments
    def arguments
      return '' unless params && !params.empty?
      params.map(&:name).join(', ')
    end

    # @return [String] string of "at" arguments "@arg1, @arg2"
    def at_arguments
      return '' unless params && !params.empty?
      params.map{|p| "@#{p.name}"}.join(', ')
    end

    # @return [String] string of keyword arguments
    def keyword_arguments
      return '' unless params && !params.empty?
      params.map(&:name).join(':, ') + ':'
    end

  end
end
