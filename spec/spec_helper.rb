ENV['RACK_ENV'] = 'test'
require('rspec')
require('pg')
require('sinatra/activerecord')
require('project')
require('user')

RSpec.configure do |config|
  config.after(:each) do
    # Project.all.each(&:destroy)
  end
end
