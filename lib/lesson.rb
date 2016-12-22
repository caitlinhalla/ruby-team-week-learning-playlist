class Lesson < ActiveRecord::Base
  has_and_belongs_to_many(:playlists)
  has_and_belongs_to_many(:tags)
  has_and_belongs_to_many(:users)
  validates(:description, :presence => true)
  validates(:title, :presence => true)
  validates(:external_link, :presence => true)
  after_initialize(:init)

  def init
    self.is_private = false if self.is_private.nil?
    self.complete = false if self.complete.nil?
  end

  def url 
    url_check = self.external_link
    if url_check.include? "https://www."
      url_check
    else
      url_check = ("https://www.") +url_check
    end
  url_check
  end
end
