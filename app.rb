require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
# require('./lib/project')

get('/') do
  erb(:index)
end
