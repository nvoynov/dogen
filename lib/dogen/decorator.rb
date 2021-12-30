require 'cleon'

module Dogen

  # Genral decorator for the domain classes
  # Cleon::Decor cannot cope with symbols
  class Decorator < Cleon::Decor
    def name
      super.to_s
    end

    def keyword_arguments
      return '' unless params && !params.empty?
      params.map(&:name).join(':, ') + ':'
    end
  end
end
