get('/playlists/new') do
  erb(:playlist_form)
end

post('/playlists') do
  name = params.fetch('playlist_name')
  due_date = params.fetch('due_date')
  is_private = params.has_key?('private')
  Playlist.create({:name => name, :due_date => due_date, :is_private => is_private})
  redirect('/dashboard')
end

get('/playlists') do
  @playlists = Playlist.all
  erb(:playlist_list)
end

get('/playlists/:id/edit') do
  @playlist = Playlist.find(params.fetch('id').to_i)
  erb(:playlist_edit)
end

patch('/playlists/:id') do
  playlist = Playlist.find(params.fetch('id').to_i)
  playlist.update({:name => params.fetch('playlist_name')})
  redirect('/playlists')
end

delete('/playlists/:id') do
  Playlist.find(params.fetch('id').to_i).destroy
  redirect('/playlists')
end
