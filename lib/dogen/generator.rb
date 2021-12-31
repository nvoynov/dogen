require 'erb'
require 'cleon'
require_relative 'decorator'
require_relative 'branded'

module Dogen

  # Source code generator for Domain
  class Generator
    include BrandedFile

    def self.call(*args)
      new(*args).call
    end

    private_class_method :new

    # !!! it must be called only in model home directory
    # @param dom [Domain] source model for code generation
    # @param base [String] base folder
    def initialize(dom, base)
      @dom = GuardDomain.(dom)
      @base = base
      @home = Home.new(base)
      @deco = Decorator
      @include = {}
      @templates = {}
      @renderers = {}
    end

    def call
      @log = []
      @log.concat(@home.furnish) unless @home.furnished?
      generate_arguards
      generate_entities
      generate_services
      generate_includes
      @log
    end

    GuardsWrapper = Struct.new(:name, :items)
    def generate_arguards
      wrapper = GuardsWrapper.new('arguards', @dom.types.map{|t| @deco.new(t)})
      types = @deco.new(wrapper, @dom.name)
      do_generate(types, config[:guards])
    end

    def generate_entities
      items = @dom.entities.map{|i| @deco.new(i, @dom.name)}
      items.each{|i| do_generate(i, config[:entity])}
    end

    def generate_services
      items = @dom.services.map{|i| @deco.new(i, @dom.name)}
      items.each{|i| do_generate(i, config[:service])}
    end

    def generate_includes
      @include.each.each do |target, include|
        incl = include.map{|i| i.sub(/.rb\z/, '')}
        prfx = target =~ /services/ ? 'services' : 'entities'
        code = []
        incl.unshift(target =~ /services/ ? 'service' : 'entity')
        incl.each{|i| code << "require_relative '#{prfx}/#{i}'"}

        write_file(target, code.join(?\n))
      end
    end

    def do_generate(model, params)
      @model = model

      builder = renderer(params[:code_erb])
      content = builder.result(binding)
      write_file(File.join(params[:code_dir], model.source), content)
      do_include(model.source, params[:include]) if params[:include]

      builder = renderer(params[:spec_erb])
      content = builder.result(binding)
      write_file(File.join(params[:spec_dir], model.spec), content)
    end

    def write_file(name, content)
      if File.exist?(name)
        FileUtils.cp name, name + '~'
        @log << name + '~'
      end
      write_branded(name, content, @dom.name)
      @log << name
    end

    # Registers items that must be required by require_relative
    # @param source [String] ruby source to include require_relative
    # @param target [String] ruby source where include require_relative
    def do_include(source, target)
      @include[target] ||= []
      @include[target] << source
    end

    def renderer(source)
      @templates[source] = File.read(source) unless @templates[source]
      erb = @templates[source]
      @renderers[source] || @renderers[source] = ERB.new(erb, trim_mode: '-')
    end

    def config
      @config ||= {}.tap do |cfg|
        cfg[:guards] = {
          code_erb: "#{Dogen.root}/lib/erb/arguards.rb.erb",
          spec_erb: "#{Dogen.root}/lib/erb/arguards_spec.rb.erb",
          code_dir: "lib/#{@home.base}",
          spec_dir: "test/#{@home.base}"
        }
        cfg[:service] = {
          code_erb: "#{Dogen.root}/lib/erb/service.rb.erb",
          spec_erb: "#{Dogen.root}/lib/erb/service_spec.rb.erb",
          code_dir: "lib/#{@home.base}/services",
          spec_dir: "test/#{@home.base}/services",
          include: "lib/#{@home.base}/services.rb"
        }
        cfg[:entity] = {
          code_erb: "#{Dogen.root}/lib/erb/entity.rb.erb",
          spec_erb: "#{Dogen.root}/lib/erb/entity_spec.rb.erb",
          code_dir: "lib/#{@home.base}/entities",
          spec_dir: "test/#{@home.base}/entities",
          include: "lib/#{@home.base}/entities.rb"
        }
      end
    end

  end

end
