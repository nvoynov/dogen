require_relative '../spec_helper'

describe Decorator do

  Decorated = Struct.new(:name, :params)

  let(:deco1) { Decorator.new(Decorated.new('name', [])) }
  let(:deco2) { Decorator.new(Decorated.new(:name, [:para1, :para2])) }
  let(:deco3) { Decorator.new(Decorated.new('user wallet', [:para1, :para2])) }

  describe '#name' do
    it 'must return string' do
      assert_instance_of String, deco1.name
      assert_instance_of String, deco2.name
      assert_instance_of String, deco3.name
    end
  end

  describe '#sanitize(str)' do
    it 'must return sanitized string' do
      assert_equal 'user', deco1.sanitize(' user ')
      assert_equal 'user_wallet', deco1.sanitize('user wallet')
      assert_equal 'user_wallet', deco1.sanitize(' user  wallet   ')
    end
  end

  describe '#constanize(str)' do
    it 'must return constanized string' do
      assert_equal 'UserWallet', deco1.constanize('user wallet')
      assert_equal 'UserWallet', deco1.constanize(' user  wallet  ')
    end
  end

  describe '#const' do
    let(:const1) { 'Name' }
    let(:const2) { 'Name' }
    let(:const3) { 'UserWallet' }

    it 'must return ruby const' do
      assert_equal deco1.const, const1
      assert_equal deco2.const, const2
      assert_equal deco3.const, const3
    end
  end

  describe '#root_const' do
    let(:deco) { Decorated.new('name', []) }
    it 'must return const' do
      assert_equal 'User', Decorator.new(deco, 'user').root_const
      assert_equal 'UserWallet', Decorator.new(deco, 'user wallet').root_const
    end
  end

  describe '#source' do
    it 'must return ruby soruce file' do
      assert_equal 'name.rb', deco1.source
      assert_equal 'user_wallet.rb', deco3.source
    end
  end

  describe '#spec' do
    it 'must return ruby soruce file' do
      assert_equal 'name_spec.rb', deco1.spec
      assert_equal 'user_wallet_spec.rb', deco3.spec
    end
  end

  describe '#arguments' do
    it 'must return keyword_arguments string' do
      assert_equal '', deco1.arguments
      assert_equal 'para1, para2', deco2.arguments
    end
  end

  describe '#at_arguments' do
    it 'must return keyword_arguments string' do
      assert_equal '', deco1.at_arguments
      assert_equal '@para1, @para2', deco2.at_arguments
    end
  end

  describe '#keyword_arguments' do
    it 'must return keyword_arguments string' do
      assert_equal '', deco1.keyword_arguments
      assert_equal 'para1:, para2:', deco2.keyword_arguments
    end
  end

end
