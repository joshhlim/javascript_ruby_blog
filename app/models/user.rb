require 'bcrypt'

class User < ActiveRecord::Base
  has_many :entries
  # Remember to create a migration!
  validates :email, uniqueness: true, presence: true
  validates :full_name, :hashed_password, presence: true

  def authenticate(email, password)
    if email == self.email && self.password == password
      return User.find_by(email: email)
    else
      nil
    end
  end

  def password
    @password ||= BCrypt::Password.new(self.hashed_password)
  end

  def password=(new_password)
    bcrypt_password = BCrypt::Password.create(new_password)
    self.hashed_password = bcrypt_password
  end
end
