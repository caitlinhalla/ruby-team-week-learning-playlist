require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/user')
require('./lib/playlist')
require('./lib/student')
require('./lib/lesson')
require('./helpers/session')



get('/') do
  erb(:index)
end
