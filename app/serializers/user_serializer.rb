class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone, :role_id, :auth_token, :profile_status

  has_one :profile
end
