require 'bcrypt'

class User < ActiveRecord::Base
  # Remember to create a migration!
  include BCrypt
  has_many :entries
  validates :username, :email, :hashed_password, {presence: true}
  validates :username, :email, { uniqueness: true }

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password
  end

  def self.authenticate(email, password)
    @user = User.find_by(email: email)
    @user.password == password ? true : false
  end
end
