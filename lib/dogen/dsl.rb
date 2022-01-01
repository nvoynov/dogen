require_relative 'domain'

module Dogen

  class DSL
    attr_reader :dom

    def self.build(name = 'Something', desc = '', &block)
      dsl = new(name, desc)
      dsl.instance_eval(&block) if block_given?
      dsl.dom
    end

    private_class_method :new

    def initialize(name, desc)
      @dom = Domain.new(name, desc)
    end

    def name(name)
      @dom.name = GuardName.(name)
    end

    def desc(desc)
      @dom.desc = GuardDesc.(desc)
    end

    def type(name, desc = '', errm:, spec:)
      t = Type.new(name, desc, errm: errm, spec: spec)
      @dom.add_type(t)
    end

    def check_and_get_type!(name)
      t = @dom.types.find{|t| t.name == name}
      t = @dom.entities.find{|e| e.name == name} unless t
      raise ArgumentError.new(
        <<~EOF
          Unknown type '#{name}'
          Type should be defined before using
          type 'username', errm: ':%s must be String', spec: 'v.is_a?(String)'
        EOF
      ) unless t
      t
    end

    def entity(name, desc = '', &block)
      e = Entity.new(name, desc)
      @dom.add_entity(e)
      instance_eval(&block) if block_given?
      e
    end

    def check_and_get_entity!
      e = @dom.entities.last
      raise ArgumentError.new(
        <<~EOF
          :atrb can only be used inside an entity block
          entity 'user' do
            atrb 'name', 'user name', type: 'username'
          end
        EOF
      ) unless e
      e
    end

    def atrb(name, desc = '', type:, default: '#$%')
      e = check_and_get_entity!
      t = check_and_get_type!(type)
      a = Para.new(name, desc, type: t, default: default)
      e << a
    end

    def service(name, desc = '', &block)
      s = Service.new(name, desc)
      @dom.add_service(s)
      instance_eval(&block) if block_given?
      s
    end

    def param(name, desc = '', type:, default: '#$%')
      s = check_and_get_last_service!
      # TODO: type might be entity!
      t = check_and_get_type!(type)
      a = Para.new(name, desc, type: t, default: default)
      s.add_param(a)
    end

    def result(name, desc = '', type:, default: '#$%')
      s = check_and_get_last_service!
      t = check_and_get_type!(type)
      a = Para.new(name, desc, type: t, default: default)
      s.add_result(a)
    end

    private

    def check_and_get_last_service!
      s = @dom.services.last
      raise ArgumentError.new(
      <<~EOF
        :param can only be used inside an service block
        service 'register_user' do
          param 'name', 'user name', type: 'username'
        end
      EOF
      ) unless s
      s
    end

    def check_and_get_service!(name)
      s = @dom.services.find{|i| i.name == name}
      raise ArgumentError.new(
      <<~EOF
        to use :sevice one should define it first
        service 'register_user' do
          param 'name', 'user name', type: 'username'
        end
        web 'register_user', :service => :register_user
        lib 'register_user', :service => :register_user
      EOF
      ) unless s
      s
    end
  end

end
