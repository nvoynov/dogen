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

end
