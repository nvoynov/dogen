require_relative '../spec_helper'
include Dogen

describe CLI do
  describe 'dry-run dogen(model, dir)' do

    let(:output) {
      <<~EOF
        Dogen: generate skeleton for 'Users'..
          created users
          created Clone Cleon to get service and entity abstractions!
          created lib
          created lib/users
          created lib/users/services
          created lib/users/entities
          created test
          created test/users
          created test/users/services
          created test/users/entities
          created lib/users/arguards.rb
          created test/users/arguards_spec.rb
          created lib/users/entities/credentials.rb
          created test/users/entities/credentials_spec.rb
          created lib/users/entities/user.rb
          created test/users/entities/user_spec.rb
          created lib/users/services/register_user.rb
          created test/users/services/register_user_spec.rb
          created lib/users/services/authenticate_user.rb
          created test/users/services/authenticate_user_spec.rb
          created lib/users/services/change_user_password.rb
          created test/users/services/change_user_password_spec.rb
          created lib/users/services/select_users.rb
          created test/users/services/select_users_spec.rb
          created lib/users/entities.rb
          created lib/users/services.rb
      EOF
    }

    it 'must generate for sample' do
      SpecTemp.() do
        _, _ = capture_io { CLI.sample }
        out, _ = capture_io { CLI.dogen(CLI.sample_name) }
        assert output, out
      end
    end
  end
end
