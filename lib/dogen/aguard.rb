module Dogen

  # Argument Guard
  #
  # @example
  #    # create a new guard for strings
  #    GuardString = AGuard.new('string', 'must be String'
  #      Proc.new{|v| v.is_a?(String)})
  #
  #    # use the guard somewhere in initialize
  #    class GuardArgument
  #      def initialize(arg)
  #        @arg = GuardString.(arg)
  #        @arg = GuardString.(arg, 'arg')
  #        @arg = GuardString.(arg, 'arg', 'specific message')
  #      end
  #    end
  class AGuard

    # @param name [String] name of the guard
    # @param meesage [String] ArgumentError message
    # @param block [Proc] spec of the guard, must return true or false
    # @return [AGuard]
    def self.new(name, message, block)
      Class.new do
        define_singleton_method "call" do |val, aname = name, amessage = message|
          return val if block.call(val)
          raise ArgumentError, ":#{aname} #{amessage}", caller[0..-1]
        end
      end
    end
  end

end
