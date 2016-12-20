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
require('sinatra/flash')

enable :sessions
register Sinatra::Flash
set :session_secret, "supersecret"
require('./helpers/session')

if User.all.length == 0
  User.create({:username => "krieger", :password => "guest"})
end

get('/') do
  @user = env['warden'].user
  erb(:index)
end

get('/dashboard') do
  erb(:student_dashboard)
end

get('/auth/login') do
  erb(:_login_form)
end

post('/auth/login') do
  env['warden'].authenticate!
  flash[:success] = "Successfully logged in. Welcome #{env['warden'].user.username}"
  if session[:return_to].nil?
    redirect '/'
  else
    redirect session[:return_to]
  end
end

get '/auth/logout' do
   env['warden'].raw_session.inspect
   env['warden'].logout
   flash[:success] = 'Successfully logged out'
   redirect '/'
 end

post('/auth/unauthenticated') do
  session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?

  flash[:error] = env['warden.options'][:message] || "You must log in"
  redirect '/'
end

get '/auth/register' do
  erb(:_register)
end

post '/auth/register' do
  p params
  env['warden'].logout
  if params['user']['password'] == params['user']['password-repeat']
    if User.find_by_username(params['user']['username'])
      flash[:error] = "A user with that username already exists"
      redirect '/'
    else
      User.create({:username => params['user']['username'], :password => params['user']['password']})
      env['warden'].authenticate!
      flash[:success] = "Registration Successful. Welcome #{params['user']['username']}"
      redirect '/'
    end

  else
    flash[:error] = "Your passwords must match"
    redirect '/'
  end

end

get '/protected' do
  env['warden'].authenticate!
  @user = env['warden'].user
  erb :protected
end
