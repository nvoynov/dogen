require_relative 'dsl'

module Dogen

  class DSL::Error < StandardError; end

  class DSLReader < DSL

    def self.call(source)
      code = File.read(source)
      dsl = new("Unknown", source)
      dsl.read(code)
    end

    def read(code)
      self.instance_eval code
      dom
    rescue NameError => e
      line = nil
      name = first_match(e.message, GET_UNDEFINED)
      line = code.lines.index{|l| l =~ %r{(^|[^'"])\b#{name}\b}} if name
      error!(ERR_UNDEFINED % name, line)
    rescue ArgumentError => e
      error!(e.message)
    end

    private

    def first_match(source, regexp)
      return nil unless match = source.match(regexp)
      match.captures.first
    end

    def error!(message, line = 0)
      message = error_message(message, line) + ?\n + DEBUG_DSL_TIP
      raise DSL::Error, message, caller(1,2)
    end

    def error_message(message, line)
      "#{message}, line: #{line}"
    end

    GET_UNDEFINED = %r{undefined local variable or method `([^']*)}
    ERR_UNDEFINED = "undefined local variable or method '%s'"

    DEBUG_DSL_TIP = <<~EOF
      Consider writing DSL as an usual Ruby script. When it's ready
      you can just comment require 'dogen', 'DSL.build', final 'end'

      require 'dogen'
      DSL.build do
        name 'Users'
        #...
      end
    EOF
  end

end
