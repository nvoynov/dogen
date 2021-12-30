require_relative '../spec_helper'
require_relative 'demo_domain'
include Dogen

describe 'Generate Demo domain' do

  let(:domain) { build_demo_domain }

  let(:created) {
    <<~EOF.lines.map(&:strip)
      lib/temp/arguards.rb~
      lib/temp/arguards.rb
      test/temp/arguards_spec.rb
      lib/temp/entities/credentials.rb
      test/temp/entities/credentials_spec.rb
      lib/temp/entities/user.rb
      test/temp/entities/user_spec.rb
      lib/temp/services/register_user.rb
      test/temp/services/register_user_spec.rb
      lib/temp/services/authenticate_user.rb
      test/temp/services/authenticate_user_spec.rb
      lib/temp/services/change_user_password.rb
      test/temp/services/change_user_password_spec.rb
      lib/temp/services/select_users.rb
      test/temp/services/select_users_spec.rb
      lib/temp/entities.rb~
      lib/temp/entities.rb
      lib/temp/services.rb~
      lib/temp/services.rb
    EOF
  }

  # describe 'sample' do
  #   it 'must create sample' do
  #     model = Decorator.new(domain)
  #     Dir.chdir('test/samples') do
  #       Generator.(domain, Dir.pwd)
  #     end
  #   end
  # end

  describe '#call(dom, path)' do
    it 'must generate list of :created' do
      # bundle gem :name --quiet
      SpecGem.('temp', true) do
        log = Generator.(domain, Dir.pwd)
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
