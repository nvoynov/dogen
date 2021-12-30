require_relative '../spec_helper'

describe Decorator do

  Decorated = Struct.new(:name, :params)

  let(:deco1) { Decorator.new(Decorated.new('name', [])) }
  let(:deco2) { Decorator.new(Decorated.new(:name, [:para1, :para2])) }

  describe '#name' do
    it 'must return string' do
      assert_instance_of String, deco1.name
      assert_instance_of String, deco1.name
    end
  end

  describe '#keyword_arguments' do
    it 'must return keyword_arguments string' do
      assert_equal '', deco1.keyword_arguments
      assert_equal 'para1:, para2:', deco2.keyword_arguments
    end
  end

end
