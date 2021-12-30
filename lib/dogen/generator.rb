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

    # @param dom [Domain] source model for code generation
    # @param path [String] path to place generated code
    def initialize(dom, path)
      @dom = GuardDomain.(dom)
      @path = path
      @deco = Decorator
      @meta = Cleon::MetaGem.new(path)
      # services.rb: [build.rb, compile.rb, ...]
      # entities.rb: [user.rb, credentials.rb, ...]
      @include = {}
      @templates = {}
      @renderers = {}
    end

    def call
      Cleon.clone_cleon(@path) unless @meta.cleon_gem?
      @log = []
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
      # TODO: real work with banner!
      # @log << File.join(@path, filename)
      filename = File.join(@path, name)
      if File.exist?(filename)
        FileUtils.cp filename, filename + '~'
        @log << name + '~'
      end
      write_branded(filename, content, @dom.name)
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
          code_dir: "lib/#{@meta.base}",
          spec_dir: "test/#{@meta.base}"
        }
        cfg[:service] = {
          code_erb: "#{Dogen.root}/lib/erb/service.rb.erb",
          code_dir: "lib/#{@meta.base}/services",
          spec_erb: "#{Dogen.root}/lib/erb/service_spec.rb.erb",
          spec_dir: "test/#{@meta.base}/services",
          include: "lib/#{@meta.base}/services.rb"
        }
        cfg[:entity] = {
          code_erb: "#{Dogen.root}/lib/erb/entity.rb.erb",
          code_dir: "lib/#{@meta.base}/entities",
          spec_erb: "#{Dogen.root}/lib/erb/entity_spec.rb.erb",
          spec_dir: "test/#{@meta.base}/entities",
          include: "lib/#{@meta.base}/entities.rb"
        }
      end
    end

  end

end
