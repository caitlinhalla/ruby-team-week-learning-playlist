class Lesson < ActiveRecord::Base
  has_and_belongs_to_many(:playlists)
  has_and_belongs_to_many(:tags)
  has_and_belongs_to_many(:users)

  after_initialize(:init)

  scope(:all_public, -> { where({:is_private => false}) })


  def init
    self.is_private = false if self.is_private.nil?
    self.complete = false if self.complete.nil?
  end
  class << self
    def all_links
      all.map(&:external_link)
    end
  end
end
