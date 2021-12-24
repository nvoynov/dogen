require_relative '../spec_helper'
include Dogen

module SharedGuardSpecs
  extend Minitest::Spec::DSL

  # must be provided in target module:
  #   let(:guard) { GuardName }
  #   let(:valid) { ["name", :name] }
  #   let(:wrong) { [nil, 1, Object.new]}

  it 'must return value' do
    valid.each{|v| assert_equal v, guard.(v)}
  end

  it 'must raise ArgumentError' do
    wrong.each{|w| assert_raises(ArgumentError) { guard.(w) }}
  end

end

describe 'Domain Guards' do

  describe GuardName do
  # GuardName = AGuard.new("name", ":%s must be String or Symbol",
  #   Proc.new{|v| v.is_a?(String) || v.is_a?(Symbol)})
    let(:guard) { GuardName }
    let(:valid) { ["name", :name] }
    let(:wrong) { [nil, 1, Object.new]}


  end
  #
  # GuardSpec = AGuard.new("spec",
  #   ":% must be String stands for Proc like '|v| v.is_a?(String)'",
  #   Proc.new{|v| v.is_a?(String) && v =~ /v\./})
  #
  # GuardErrm = AGuard.new("errm", ":%s must be String",
  #   Proc.new{|v| v.is_a?(String)})
  #
  # GuardType = AGuard.new("errm", ":%s must be Type",
  #   Proc.new{|v| v.is_a?(Type)})
  #
  # GuardPara = AGuard.new("errm", ":%s must be Para",
  #   Proc.new{|v| v.is_a?(Para)})
  #
  # GuardDesc = AGuard.new("desc", ":%s must be String",
  #   Proc.new{|v| v.is_a?(String)})
  #
  # GuardService = AGuard.new("service", ":%s must be Service",
  #   Proc.new{|v| v.is_a?(Service)})
  #
  # GuardEntity = AGuard.new("entity", ":%s must be Entity",
  #   Proc.new{|v| v.is_a?(Entity)})
  #
  # GuardEntityOrType  = AGuard.new("entity", ":%s must be Type|Entity",
  #   Proc.new{|v| v.is_a?(Entity) || v.is_a?(Type)})
  #
  # GuardCall = AGuard.new("call", ":%s must be Call",
  #   Proc.new{|v| v.is_a?(Call)})
  #
  # GuardDomain = AGuard.new("domain", ":%s must be Domain",
  #   Proc.new{|v| v.is_a?(Domain)})

end
