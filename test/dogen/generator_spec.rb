require_relative '../spec_helper'
include Dogen

describe Generator do
  let(:domain) {
    DSL.build do
      name 'Users'

      type :string, 'general string of 256 characters',
        errm: 'must be String[256]',
        spec: 'v.is_a?(String) && v.length <= 256'

      entity :user, 'Registered User' do
        atrb :name, 'the name of the user', :type => :string
      end

      service :register, 'Register a new user' do
        param :name, 'name of a new user', :type => :string
        param :secret, 'secret of a new user', :type => :string
        result :user, 'registered user', :type => :user
      end

      entity :orphan, 'Not attributes'      # jsut to check entity templates
      service :orphan, 'No input parameters'# jsut to check service templates
    end
  }

  let(:created) {
    <<~EOF.lines.map(&:strip)
      lib/temp/arguards.rb~
      lib/temp/arguards.rb
      test/temp/arguards_spec.rb
      lib/temp/entities/user.rb
      test/temp/entities/user_spec.rb
      lib/temp/entities/orphan.rb
      test/temp/entities/orphan_spec.rb
      lib/temp/services/register.rb
      test/temp/services/register_spec.rb
      lib/temp/services/orphan.rb
      test/temp/services/orphan_spec.rb
      lib/temp/entities.rb~
      lib/temp/entities.rb
      lib/temp/services.rb~
      lib/temp/services.rb
    EOF
  }

  describe '#call(dom, path)' do
    it 'must generate list of :created' do
      SpecGem.('temp') do
        log = nil
        _, _ = capture_io { log = Generator.(domain, Dir.pwd) }        
        assert_equal created, log
      end
    end
  end
end
