require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/user')
require('./lib/playlist')
require('pry')
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

before do
  @user = env['warden'].user
end

get('/') do
  erb(:index)
end

get('/dashboard') do
  @playlists = Playlist.all
  erb(:student_dashboard)
end

get('/dashboard/lessons') do
  @lessons = Lesson.all
  erb(:lesson_list)
end

get('/dashboard/lesson_detail/:id') do
  @lesson = Lesson.find(params.fetch('id').to_i)
  erb(:lesson_detail)
end

post('/dashboard/lessons') do
  title = params.fetch('lesson_title')
  description = params.fetch('lesson_description')
  link = params.fetch('external_link')
  is_private = params.has_key?('is_private')
  @lesson = Lesson.create({:title => title, :description => description, :external_link => link, :is_private => is_private})
  redirect '/dashboard/lessons'
end

patch('/dashboard/lessons/:id') do
  @lesson = Lesson.find(params.fetch('id').to_i)
  title = params.fetch('lesson_title')
  description = params.fetch('lesson_description')
  link = params.fetch('external_link')
  is_private = params.has_key?('is_private')
  @lesson.update({:title => title, :description => description, :external_link => link, :is_private => is_private})
  redirect "/dashboard/lesson_detail/#{params.fetch('id').to_i}"
end

delete('/dashboard/lessons/:id') do
  @lesson = Lesson.find(params.fetch('id').to_i)
  @lesson.destroy()
  @lessons = Lesson.all()
  redirect '/dashboard/lessons'
end

get('/playlists/new') do
  erb(:playlist_form)
end

post('/playlists/new') do
  name = params.fetch('playlist_name')
  due_date = params.fetch('due_date')
  is_private = params.has_key?('private')
  @playlist = Playlist.create({:name => name, :due_date => due_date, :is_private => is_private})
  @playlists = Playlist.all
  redirect('/dashboard')
end

get('/playlists') do
  @playlists = Playlist.all
  erb(:playlists)
end

get('/playlists/:id/edit') do
  @playlist = Playlist.find(params.fetch('id').to_i)
  erb(:playlist_edit)
end

patch('/playlists/:id') do
  @playlist = Playlist.find(params.fetch('id').to_i)
  name = params.fetch('playlist_name')
  @playlist.update({:name => name})
  redirect('/playlists')
end

delete('/playlists/:id') do
  @playlist = Playlist.find(params.fetch('id').to_i)
  @playlist.delete
  redirect('/playlists')
end

get('/auth/login') do
  erb(:_login_form)
end

post('/auth/login') do
  env['warden'].authenticate!
  flash[:success] = "Successfully logged in. Welcome #{env['warden'].user.username}"
  if session[:return_to].nil?
    redirect '/dashboard'
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
