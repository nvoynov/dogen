require_relative '../spec_helper'

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
