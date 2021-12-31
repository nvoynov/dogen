require_relative '../spec_helper'
require_relative 'demo_domain'
include Dogen

describe 'Generate Demo domain' do

  let(:domain) { build_demo_domain }

  let(:created) {
    <<~EOF.lines.map(&:strip)
      Cloning Cleon might help this skeleton
      lib
      lib/users
      lib/users/services
      lib/users/entities
      test
      test/users
      test/users/services
      test/users/entities
      lib/users/arguards.rb
      test/users/arguards_spec.rb
      lib/users/entities/credentials.rb
      test/users/entities/credentials_spec.rb
      lib/users/entities/user.rb
      test/users/entities/user_spec.rb
      lib/users/services/register_user.rb
      test/users/services/register_user_spec.rb
      lib/users/services/authenticate_user.rb
      test/users/services/authenticate_user_spec.rb
      lib/users/services/change_user_password.rb
      test/users/services/change_user_password_spec.rb
      lib/users/services/select_users.rb
      test/users/services/select_users_spec.rb
      lib/users/entities.rb
      lib/users/services.rb
    EOF
  }

  describe '#call(dom, path)' do
    it 'must generate list of :created' do
      SpecTemp.() do
        home = Home.new(domain.name)
        log = Generator.(domain, home.base)
        assert_equal created, log

        # Dir.chdir('lib') do
        #   # puts Dir.pwd
        #   # TODO: mainrb depends on SpecGem.("temp")
        #   # mainrb = Decorator.new(domain).source.sub(/.rb\z/, '')
        #   mainrb = 'temp.rb'
        #   script = "require './#{mainrb}'; puts '42'"
        #   out, err = capture_io { system "ruby -e \"#{script}\"" }
        #   assert_match /42/, out
        # end
      end
    end
  end
end
