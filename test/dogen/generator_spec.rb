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
      Cloning Cleon might help this skeleton
      lib
      lib/spec
      lib/spec/services
      lib/spec/entities
      test
      test/spec
      test/spec/services
      test/spec/entities
      lib/spec/arguards.rb
      test/spec/arguards_spec.rb
      lib/spec/entities/user.rb
      test/spec/entities/user_spec.rb
      lib/spec/entities/orphan.rb
      test/spec/entities/orphan_spec.rb
      lib/spec/services/register.rb
      test/spec/services/register_spec.rb
      lib/spec/services/orphan.rb
      test/spec/services/orphan_spec.rb
      lib/spec/entities.rb
      lib/spec/services.rb
    EOF
  }

  let(:furnished) {
    <<~EOF.lines.map(&:strip)
      lib/spec/arguards.rb
      test/spec/arguards_spec.rb
      lib/spec/entities/user.rb
      test/spec/entities/user_spec.rb
      lib/spec/entities/orphan.rb
      test/spec/entities/orphan_spec.rb
      lib/spec/services/register.rb
      test/spec/services/register_spec.rb
      lib/spec/services/orphan.rb
      test/spec/services/orphan_spec.rb
      lib/spec/entities.rb
      lib/spec/services.rb
    EOF
  }

  let(:base) { 'spec' }

  describe '#call(dom, base)' do
    it 'must generate list of :created when not cleoned' do
      SpecTemp.() do
        log = Generator.(domain, base)
        assert_equal created, log
      end
    end

    it 'must generate list of :created when cleoned' do
      SpecTemp.() do
        home = Home.new(base)
        home.furnish
        log = Generator.(domain, base)
        assert_equal furnished, log
      end
    end
  end
end
