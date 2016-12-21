class Tag < ActiveRecord::Base
  has_and_belongs_to_many(:lessons)
  has_and_belongs_to_many(:playlists)

  class << self
     def make_all(list)
       list.split(",").map(&:strip).map do |tag_name|
         if tag = Tag.find_by_name(tag_name)
           tag
         else
           Tag.create({:name => tag_name})
         end
       end
     end
   end
 end
