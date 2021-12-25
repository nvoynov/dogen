require_relative '../spec_helper'

describe Decorator do

  Deco = Struct.new(:name)

  let(:unit) { "Some::Unit" }
  let(:deco1) { Deco.new(:long_const) }
  let(:deco2) { Deco.new(:const) }
  let(:decorator0) { Decorator.new(deco1) }
  let(:decorator1) { Decorator.new(deco1, unit) }
  let(:decorator2) { Decorator.new(deco2, unit) }

  describe '#name' do
    it 'must be string' do
      assert_instance_of String, decorator0.name
      assert_instance_of String, decorator1.name
      assert_instance_of String, decorator2.name
    end
  end

  describe '#const' do
    it 'must be familiar Ruby constant' do
      assert_equal 'LongConst', decorator1.const
      assert_equal 'Const', decorator2.const
    end

    it 'must downcase and turn spaces to _' do
      args = ['Must be oK ', ' Must BE OK ',
              'Must be ok  ','  Must be ok',
              'Must   be ok']
      args.each{|arg|
        assert_equal 'MustBeOk', Decorator.new(Deco.new(arg)).const
      }
    end
  end

  describe '#full_const' do
    it 'must be familiar Ruby constant' do
      assert_equal "LongConst", decorator0.full_const
      assert_equal "#{unit}::LongConst", decorator1.full_const
      assert_equal "#{unit}::Const", decorator2.full_const
    end
  end

end
