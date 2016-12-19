class Student < ActiveRecord::Base
  has_many(:playlists)
end
