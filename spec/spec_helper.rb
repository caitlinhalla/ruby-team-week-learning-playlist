ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

require('./app')


RSpec.configure do |config|
  config.after(:each) do
    Lesson.all.each(&:destroy)
    Playlist.all.each(&:destroy)
    User.all.each(&:destroy)
    Tag.all.each(&:destroy)
  end
end
