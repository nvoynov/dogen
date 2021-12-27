require_relative '../spec_helper'
require_relative 'shared_domain'

describe Gen do
  let(:dom) { build_users_domain }

  it 'just dry-run' do
    Sandbox.() do
      Gen.(dom)
      ruby_code = "require './_dogen'; puts '42'"
      out, _ = capture_subprocess_io do
        system "ruby -e \"#{ruby_code}\""
      end
      assert_match %r{42}, out
    end
  end

  describe '#call' do
    it 'must generate model sources'
    it 'must create .rb~ and @log when target file exists and changed'
    it 'must create service.rb and entity.rb when these do not exist'
    it 'must left original service.rb and entity.rb'
  end

end
