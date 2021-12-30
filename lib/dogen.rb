# frozen_string_literal: true

require_relative "dogen/version"
require_relative "dogen/arguard"
require_relative "dogen/decorator"
require_relative "dogen/generator"
require_relative "dogen/branded"
require_relative "dogen/domain"
require_relative "dogen/dsl"
require_relative "dogen/cli"

module Dogen
  class Error < StandardError; end

  class << self
    def root
      File.dirname __dir__
    end
  end
end
