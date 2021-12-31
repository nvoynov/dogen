# This is an example how to build Cleon model for Users Managment
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
  atrb :email, 'email used as login', type: :email
  atrb :password, 'password', type: :password
end

entity :user do
  atrb :uid, 'unique user identifier', type: :uuid, default: nil
  atrb :name, 'name', type: :user_name
  atrb :email, 'email', type: :email
end

service :register_user do
  param :name, 'name', type: :user_name
  param :email, 'email', type: :email
  param :password, 'password', type: :password
  result :user, 'registered user', type: :user
end

service :authenticate_user do
  param :email, 'email', type: :email
  param :password, 'password', type: :password
  result :user, 'registered user', type: :user
end

service :change_user_password do
  param :email, 'email', type: :email
  param :old_password, 'old password', type: :password
  param :new_password, 'new password', type: :password
  result :user, 'user', type: :user
end

service :select_users do
  param :filter, 'filter', type: :string256
  param :order_by, 'order by', type: :string256
  param :limit, 'limit items per page', type: :five_or_more
  param :offset, 'page number', type: :zero_or_more
  result :users, 'collection of users', type: :collection
end
