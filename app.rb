require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/user')
require('./lib/playlist')
require('./lib/student')
require('./lib/lesson')
require('warden')

enable :sessions
set :session_secret, "supersecret"
require('./helpers/session')



get('/') do
  erb(:index)
end

post('/login') do
  redirect '/dashboard'
end

get('/dashboard') do
  erb(:student_dashboard)
end

get('/auth/login') do
  erb(:login)
end

post('/auth/login') do
  env['warden'].authenticate!

  if session[:return_to].nil?
    redirect '/'
  else
    redirect session[:return_to]
  end
end

get '/auth/logout' do
   env['warden'].raw_session.inspect
   env['warden'].logout
  #  flash[:success] = 'Successfully logged out'
   redirect '/'
 end

post('/auth/unauthenticated') do
  p "----------------ROUTE ACCESS--------------------"
  session[:return_to] = env['warden.options'][:message] || "You must log in"

  redirect '/auth/login'
end


get '/protected' do
  env['warden'].authenticate!

  erb :protected
end
