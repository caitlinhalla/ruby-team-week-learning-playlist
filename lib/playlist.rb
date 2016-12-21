class Playlist < ActiveRecord::Base
  has_and_belongs_to_many(:lessons)
  belongs_to(:user)
end
