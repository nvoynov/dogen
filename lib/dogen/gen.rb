require_relative 'render'
require_relative 'branded'

module Dogen

  # Source code generator for Domain
  # TODO: check if generated file already exist, check changes rewrite/report
  # TODO: create report on rewrited and unchanged files
  class Gen
    include BrandedFile

    def self.call(*args)
      new(*args).call
    end

    private_class_method :new
    # @param dom [Domain] source model for code generation
    # @param lib [String] path to place generated code
    # @param erblib [String] path to erb templated
    def initialize(dom, lib = Dir.pwd)
      @dom = GuardDomain.(dom)
      @lib = lib
      @inc = []
      @log = []
    end

    def call
      Dir.chdir(@lib) do
        gen_dependencies
        gen_collection('lib/erb/entity.rb.erb',  @dom.entities, 'entities')
        gen_collection('lib/erb/service.rb.erb', @dom.services, 'services')
        gen_dogenreq
      end
      @log
    end

    protected

    # @param name [String] filename
    # @param body [String|Array] content
    def write_file(name, body)
      if File.exist?(name)
        # when generated file was changed (md5(body))
        name = name + '~' if file_changed?(name)
        @log << [name, '~']
      end
      body, _ = body if body.is_a? Array
      write_branded(name, body, @dom.name)
    end

    # 1) checks serices/ and entities/ dirs, provide when not found
    # 2) check services/service.rb, provide when not found
    # 3) check entities/entity.rb, provide when not found
    def gen_dependencies
      %w(entities services).each{|dir| Dir.mkdir(dir) unless Dir.exist?(dir) }

      decorator = Decorator.new(@dom)
      generator = ->(source, dest) {
        erbt = File.read(source)
        body = Render.(decorator, erbt)
        write_file(dest, body)
      }

      src = File.join(Dogen.root, 'lib/erb/arguard.rb.erb')
      dst = 'arguards.rb'
      generator.call(src, dst)

      src = File.join(Dogen.root, 'lib/erb/dogen-entity.rb.erb')
      dst = File.join('entities', 'entity.rb')
      generator.call(src, dst) unless File.exist? dst

      src = File.join(Dogen.root, 'lib/erb/dogen-service.rb.erb')
      dst = File.join('services', 'service.rb')
      generator.call(src, dst) unless File.exist? dst
    end

    def gen_collection(template, collection, unit)
      src = File.join(Dogen.root, template)
      erb = File.read(src)
      par = "#{@dom.name.capitalize}::#{unit.capitalize}"
      collection
        .map{|e| Decorator.new(e, par)}
        .each do |e|
          body = Render.(e, erb)
          dest = File.join(unit, e.source_file)
          write_file(dest, body)
          @inc << dest
        end
    end

    # generates require section to compile together by Ruby
    def gen_dogenreq
      generate = ->(dest, ary) {
        include = ary
          .map{|i| i.sub(/.rb\z/, '') }
          .map{|i| "require_relative '%s'" % i}
        body = include.join(?\n)
        write_file(dest, body)
      }

      generate.call('entities.rb', @inc.select{|i| i =~ /entities/})
      generate.call('services.rb', @inc.select{|i| i =~ /services/})
      generate.call('_dogen.rb',
        %w(arguards.rb entities.rb services.rb))
    end
  end

end
