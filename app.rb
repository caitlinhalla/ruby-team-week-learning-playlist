require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/playlist')
require('pry')

get('/') do
  erb(:index)
end

post('/login') do
  redirect '/dashboard'
end

get('/dashboard') do
  @playlists = Playlist.all
  erb(:student_dashboard)
end

get('/playlists/new') do
  erb(:playlist_form)
end

post('/playlists/new') do
  name = params.fetch('playlist_name')
  due_date = params.fetch('due_date')
  privacy = params.has_key?('private')
  @playlist = Playlist.create({:name => name, :due_date => due_date, :private => privacy})
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
