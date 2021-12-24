require_relative '../spec_helper'
require_relative 'shared_guard_specs'
include Dogen

describe 'Domain Guards' do

  # GuardName = AGuard.new("name", "must be String or Symbol",
  #   Proc.new{|v| v.is_a?(String) || v.is_a?(Symbol)})
  describe GuardName do
    include SharedGuardSpecs

    let(:guard) { GuardName }
    let(:valid) { ["name", :name] }
    let(:wrong) { [nil, 1, Object.new]}
  end

  # GuardSpec = AGuard.new("spec",
  #   "must be String stands for Proc like '|v| v.is_a?(String)'",
  #   Proc.new{|v| v.is_a?(String) && v =~ /v\./})
  describe GuardSpec do
    include SharedGuardSpecs

    let(:guard) { GuardSpec }
    let(:valid) { ["v.", "v.is_a"] }
    let(:wrong) { [nil, 1, Object.new, "bla-bla-bla"]}
  end

  # GuardErrm = AGuard.new("errm", "must be String",
  #   Proc.new{|v| v.is_a?(String)})
  describe GuardErrm do
    include SharedGuardSpecs

    let(:guard) { GuardErrm }
    let(:valid) { ["", "a"] }
    let(:wrong) { [nil, 1, Object.new]}
  end

  # GuardType = AGuard.new("errm", "must be Type",
  #   Proc.new{|v| v.is_a?(Type)})
  describe GuardType do
    include SharedGuardSpecs

    let(:guard) { GuardType }
    let(:valid) { [Type.new(:type, errm: 'err', spec: 'v.')] }
    let(:wrong) { [nil, 1, "abc", Object.new] }
  end

  # GuardPara = AGuard.new("errm", ":%s must be Para",
  #   Proc.new{|v| v.is_a?(Para)})
  describe GuardPara do
    include SharedGuardSpecs

    let(:guard) { GuardPara }
    let(:valid) {
      t = Type.new(:type, errm: 'err', spec: 'v.')
      [ Para.new(:para, type: t) ]
    }
    let(:wrong) { [nil, 1, "abc", Object.new] }
  end

  # GuardDesc = AGuard.new("desc", ":%s must be String",
  #   Proc.new{|v| v.is_a?(String)})
  describe GuardDesc do
    include SharedGuardSpecs

    let(:guard) { GuardDesc }
    let(:valid) { ["", "a"] }
    let(:wrong) { [nil, 1, Object.new]}
  end

  # GuardService = AGuard.new("service", ":%s must be Service",
  #   Proc.new{|v| v.is_a?(Service)})
  describe GuardService do
    include SharedGuardSpecs

    let(:guard) { GuardService }
    let(:valid) { [ Service.new(:service) ] }
    let(:wrong) { [nil, 1, "abc", Object.new] }
  end

  # GuardEntity = AGuard.new("entity", ":%s must be Entity",
  #   Proc.new{|v| v.is_a?(Entity)})
  describe GuardEntity do
    include SharedGuardSpecs

    let(:guard) { GuardEntity }
    let(:valid) { [ Entity.new(:service) ] }
    let(:wrong) { [nil, 1, "abc", Object.new] }
  end

  # GuardEntityOrType  = AGuard.new("entity", "must be Type|Entity",
  #   Proc.new{|v| v.is_a?(Entity) || v.is_a?(Type)})
  describe GuardEntityOrType do
    include SharedGuardSpecs

    let(:guard) { GuardEntityOrType }
    let(:valid) { [Entity.new(:service),
      Type.new(:type, errm: 'err', spec: 'v.')]
    }
    let(:wrong) { [nil, 1, "abc", Object.new] }
  end

  # GuardDomain = AGuard.new("domain", ":%s must be Domain",
  #   Proc.new{|v| v.is_a?(Domain)})
  describe GuardDomain do
    include SharedGuardSpecs

    let(:guard) { GuardDomain }
    let(:valid) { [Domain.new(:domain)] }
    let(:wrong) { [nil, 1, "abc", Object.new] }
  end

end
