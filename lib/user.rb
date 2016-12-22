require('bcrypt')

class User < ActiveRecord::Base
  include BCrypt
  validates :password, confirmation: true
  has_and_belongs_to_many(:playlists)
  has_and_belongs_to_many(:lessons)


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(attempted_password)
    self.password == attempted_password
  end
end
