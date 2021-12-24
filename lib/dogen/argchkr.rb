module Dogen
  class ArgChkr
    # Creates policy class
    # @param aname [String] general name of the cheking argument
    # @param ameesage [String] the template of error message
    # @return [Cleon::ArgChkr::Policy]
    def self.new(aname, amessage, block)
      Class.new do
        define_singleton_method "valid?" do |value|
          block.call(value)
        end

        define_singleton_method "call" do |value, name: aname, message: amessage|
          raise ArgumentError, message % name, caller[0..-1] unless valid?(value)
          value
        end
      end
    end
  end

end
