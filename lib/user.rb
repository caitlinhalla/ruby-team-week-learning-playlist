require('bcrypt')

class User < ActiveRecord::Base
  include BCrypt
  validates :password, confirmation: true
  has_many(:playlists)

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

  def lessons
    self.playlists.reduce([]) {|arr, pl| arr.concat pl.lessons}
  end

  def completed_lessons
    self.lessons.keep_if {|lesson| lesson.complete }
  end


end
