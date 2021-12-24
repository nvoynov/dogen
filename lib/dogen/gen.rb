require_relative 'render'

module Dogen

  # Abstract service class
  class AGen
    def self.call(*args, **para)
      new(*args, **para).call
    end

    def call
    end
  end

  # Source code generator for Domain
  class Gen < AGen

    # @param dom [Domain] source model for code generation
    # @param lib [String] path to place generated code
    # @unit [String] parent module constant
    def initialize(dom, lib = Dir.pwd, unit: '')
      @dom = GuardDomain.(dom)
      @lib = lib
      @unit = unit
    end

    def call
      gen_arguards
      gen_entities
      gen_services
    end

    AGUARDTT = "#{Dogen.root}/erb/aguard.rb.erb"
    ENTITYTT = "#{Dogen.root}/erb/entity.rb.erb"
    SERVICTT = "#{Dogen.root}/erb/service.rb.erb"
    STREAMER = <<~EOF
      # This file was created for %s at %s
      # by using domain generator Dogen
      # --
      # [Dogen](https://github.com/nvoynov/dogen)
      # [Cleon](https://github.com/nvoynov/cleon)
      #
    EOF

    def gen_arguards
      erb = File.read(AGUARDTT)
      obj = @dom.types.map{|o| Decorator.new(o, @unit)}
      gua = Render.(obj, erb)
      src = File.join(@lib, File.basename('.erb'))

      cap = <<~EOF
        require_relative 'aguard'

        # Argument Guards
        module AGuards
      EOF
      body = [STREAMER, cap, gua, 'end'].join(?\n)
      File.write(src, body)
    end

    def gen_entities
    end

    def gen_services
    end

  end

end
