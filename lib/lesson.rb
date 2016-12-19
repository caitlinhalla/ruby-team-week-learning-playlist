class Lesson < ActiveRecord::Base
  has_many_and_belongs_to(:playlist)
end
