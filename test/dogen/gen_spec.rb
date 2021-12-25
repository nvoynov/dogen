require_relative '../spec_helper'
require_relative 'shared_domain'

describe Gen do
  let(:dom) { build_users_domain }

  it 'just dry-run' do
    Sandbox.() do
      Gen.(dom, erblib: Dogen.root)
      ruby_code = "require './_dogen'; puts '42'"
      out, err = capture_subprocess_io do
        system "ruby -e \"#{ruby_code}\""
      end
      assert_match /42/, out
    end
  end

end
