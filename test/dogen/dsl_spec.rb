require_relative '../spec_helper'
require_relative 'shared_domain'
include Dogen

describe DSL do

  it 'must self#build complex domain' do
    assert_instance_of Domain, build_users_domain
  end

  it 'DSL must be extensively tested' do
    # but a half of that must be for Domain
    skip 'DSL must be extensively tested'
  end

end
