# This is an example how to build Cleon model for Users Managment
require 'dogen'
include Dogen

def build_demo_domain
  DSL.build do
    name 'Users'
    desc 'Users Management (Cleon)'

    type :uuid, 'universally unique identifier',
      errm: 'must be UUID String[36]',
      spec: 'v.is_a?(String) && v.length == 36'

    type :string256, 'general string of 256 characters',
      errm: 'must be String[256]',
      spec: 'v.is_a?(String) && v.length <= 256'

    type :zero_or_more, 'integer',
      errm: 'must be Integer >= 0',
      spec: 'v.is_a?(Integer) && v >= 0'

    type :five_or_more, 'integer',
      errm: 'must be Integer >= 5',
      spec: 'v.is_a?(Integer) && v >= 5'

    type :collection, 'collection of items',
      errm: 'must be Array',
      spec: 'v.is_a?(Array)'

    type :user_name, 'user name',
      errm: 'must be String[3,50]',
      spec: 'v.is_a?(String) && v.length.between?(3, 50)'

    type :email, 'email',
      errm: 'must be valid email String[5,50]',
      spec: 'v.is_a?(String) && v.length.between?(3, 50)'

    type :password, 'password',
      errm: 'must be String[8,50]',
      spec: 'v.is_a?(String) && v.length.between?(8, 50)'

    entity :credentials do
      prop :email, 'email used as login', type: :email
      prop :password, 'password', type: :password
    end

    entity :user do
      prop :uid, 'unique user identifier', type: :uuid, default: nil
      prop :name, 'name', type: :user_name
      prop :email, 'email', type: :email
    end

    service :register_user do
      prop :name, 'name', type: :user_name
      prop :email, 'email', type: :email
      prop :password, 'password', type: :password
      result :user, 'registered user', type: :user
    end

    service :authenticate_user do
      prop :email, 'email', type: :email
      prop :password, 'password', type: :password
      result :user, 'registered user', type: :user
    end

    service :change_user_password do
      prop :email, 'email', type: :email
      prop :old_password, 'old password', type: :password
      prop :new_password, 'new password', type: :password
      result :user, 'user', type: :user
    end

    service :select_users do
      prop :filter, 'filter', type: :string256
      prop :order_by, 'order by', type: :string256
      prop :limit, 'limit items per page', type: :five_or_more
      prop :offset, 'page number', type: :zero_or_more
      result :users, 'collection of users', type: :collection
    end

    # api 'users/session' do
    #   post :register_user, service: :register_user
    #   post :authenticate_user, service: :authenticate_user
    #   post :change_user_password, service: :change_user_password
    # end
    #
    # api 'users' do
    #   get '/', service: :select_users
    # end
    #
    # lib 'users' do
    #   func :register_user, service: :register_user
    #   func :authenticate_user, service: :authenticate_user
    #   func :change_user_password, service: :change_user_password
    #   func :select_users, service: :select_users
    # end
  end
end
