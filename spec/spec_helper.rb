ENV['RACK_ENV'] = 'test'
require('rspec')
require('pg')
require('sinatra/activerecord')
require("shoulda-matchers")
require('lesson')
require('playlist')
require('student')
require('user')
require('tag')
require('pry')

RSpec.configure do |config|
  config.after(:each) do
    Lesson.all.each(&:destroy)
    Playlist.all.each(&:destroy)
    Student.all.each(&:destroy)
    Tag.all.each(&:destroy)
  end
end
