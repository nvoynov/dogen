require 'delegate'

module Dogen

  # Genral decorator for the domain classes
  class Decorator < SimpleDelegator
    def initialize(obj, unit = '')
      super(obj)
      @unit = unit
    end

    def name
      super.to_s
    end

    def unit
      @unit
    end

    # Create Const from name
    # @examples
    #   e1 = Domain.new('domain')
    #   Decorator.new(e).const # => 'Domain'
    #
    #   e2 = Domain.new('users_domain')
    #   Decorator.new(e2).const # => 'UsersDomain'
    #
    # @return [String] Const(name)
    def const
      name.downcase.strip.gsub(/\s{1,}/, '_')
        .split(?_).map(&:capitalize).join
    end

    # @return [String] full const from :name with :unit
    #
    # @examples
    #   e = Domain.new('users_domain', 'Dogen')
    #   Decorator.new(e).full_const # => 'Dogen::UsersDomain'
    def full_const
      unit.empty? ? const : "#{unit}::#{const}"
    end
  end
end
