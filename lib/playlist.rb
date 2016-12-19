class Playlist < ActiveRecord::Base
  has_many_and_belongs_to(:lessons)
  belongs_to(:student)
end
