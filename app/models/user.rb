class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :access_grants,
            class_name:'Doorkeeper::AccessGrant',
            foreign_key: :resource_owner_id,
            dependent: :delete_all
  has_many :access_tokens,
            class_name:'Doorkeeper::AccessToken',
            foreign_key: :resource_owner_id,
            dependent: :delete_all

  has_many :guests
  has_many :events

  validates :email, presence: true, email: true

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
