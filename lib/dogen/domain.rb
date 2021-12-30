require_relative 'arguard'

module Dogen

  GuardName = ArGuard.new("name", "must be String[3,] or Symbol",
    Proc.new{|v| (v.is_a?(String) && v.strip.length > 2) || v.is_a?(Symbol)})

  GuardSpec = ArGuard.new("spec",
    ":% must be String stands for Proc like '|v| v.is_a?(String)'",
    Proc.new{|v| v.is_a?(String) && v =~ /v\./})

  GuardErrm = ArGuard.new("errm", "must be String",
    Proc.new{|v| v.is_a?(String)})

  GuardType = ArGuard.new("errm", "must be Type",
    Proc.new{|v| v.is_a?(Type)})

  GuardPara = ArGuard.new("errm", "must be Para",
    Proc.new{|v| v.is_a?(Para)})

  GuardDesc = ArGuard.new("desc", "must be String",
    Proc.new{|v| v.is_a?(String)})

  GuardService = ArGuard.new("service", "must be Service",
    Proc.new{|v| v.is_a?(Service)})

  GuardEntity = ArGuard.new("entity", "must be Entity",
    Proc.new{|v| v.is_a?(Entity)})

  GuardEntityOrType  = ArGuard.new("entity", "must be Type|Entity",
    Proc.new{|v| v.is_a?(Entity) || v.is_a?(Type)})

  GuardCall = ArGuard.new("call", "must be Call",
    Proc.new{|v| v.is_a?(Call)})

  GuardDomain = ArGuard.new("domain", "must be Domain",
    Proc.new{|v| v.is_a?(Domain)})

  # The basic concept of a typed value that can be checked type,
  #   but not a type that hold value.
  class Type
    attr_reader :name
    attr_reader :desc
    attr_reader :spec
    attr_reader :errm

    def initialize(name, desc = '', errm:, spec:)
      @name = GuardName.(name)
      @errm = GuardErrm.(errm)
      @spec = GuardSpec.(spec)
      @desc = GuardDesc.(desc)
    end
  end

  # The basic concept of an checked paramter, that used in entities and services
  class Para
    attr_reader :name
    attr_reader :desc
    attr_reader :type
    attr_reader :default

    def initialize(name, desc = '', type:, default: '#$%')
      @name = GuardName.(name)
      @type = GuardEntityOrType.(type)
      @defaul = (default == '#$%' ? nil : default)
      @desc = GuardDesc.(desc)
    end
  end

  # The basic concept of data, that domain's services work with
  class Entity
    attr_reader :name
    attr_reader :desc
    attr_reader :attrs

    def initialize(name, desc = '')
      @name = GuardName.(name)
      @desc = GuardDesc.(desc)
      @attrs = []
    end

    def add_attr(attr)
      @attrs << GuardPara.(attr)
      attr
    end

    alias :<< :add_attr
    alias :params :attrs # hack to provide unified code in erb
  end

  # The basic concept of a service that domain provides
  class Service
    attr_reader :name
    attr_reader :desc
    attr_reader :params
    attr_reader :results

    def initialize(name, desc = '')
      @name = GuardName.(name)
      @desc = GuardDesc.(desc)
      @params = []
      @results = []
    end

    def add_param(param)
      @params << GuardPara.(param)
      param
    end

    def add_result(param)
      @results << GuardPara.(param)
      param
    end
  end

  # The domain description that consits of entities and services
  class Domain
    attr_accessor :name
    attr_accessor :desc

    attr_reader :types
    attr_reader :entities
    attr_reader :services

    def initialize(name = 'Unnamed', desc = '')
      @name = GuardName.(name)
      @desc = GuardDesc.(desc)
      @types = []
      @entities = []
      @services = []
      @webcalls = []
      @libcalls = []
    end

    def add_type(type)
      @types << GuardType.(type)
      type
    end

    def add_entity(entity)
      @entities << GuardEntity.(entity)
      entity
    end

    def add_service(service)
      @services << GuardService.(service)
      service
    end
  end

end
