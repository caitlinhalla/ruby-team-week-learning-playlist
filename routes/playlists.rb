post('/playlists') do
  name = params.fetch('playlist_name')
  description = params.fetch('playlist_description')
  due_date = params.fetch('due_date')
  is_private = params.has_key?('private')
  playlist = Playlist.new({:name => name, :description => description, :due_date => due_date, :is_private => is_private})
  if playlist.save
    new_tags = params.fetch('new-tags')
    Tag.make_all(new_tags).each do |tag|
      playlist.tags.push(tag)
    end
    env['warden'].user.playlists.push(playlist) if env['warden'].user

    redirect "/playlists/#{playlist.id}"
  else
    flash[:error] = "Name and Description cannot be blank!"
    redirect "/playlists"
  end
end

get('/playlists') do
  @playlists = Playlist.all
  @playlists = @user.playlists if env['warden'].user
  erb(:playlist_list)
end

get('/playlists/:id') do
  @playlist = Playlist.find(params.fetch('id').to_i)
  @lessons = Lesson.all
  @lessons = @user.lessons if env['warden'].user
  erb(:playlist_detail)
end

patch('/playlists/:id') do
  playlist = Playlist.find(params.fetch('id').to_i)
  name = params.fetch('playlist_name')
  description = params.fetch('new_playlist_description')
  due_date = params.fetch('new_due_date')
  playlist.update({:name => name, :description => description, :due_date => due_date})
  redirect('/playlists')
end

patch("/playlists/:id/lessons/add") do
  lesson = Lesson.find(params.fetch("lesson_id").to_i)
  playlist = Playlist.find(params.fetch("id").to_i)
  playlist.lessons.push(lesson)
  redirect "/playlists/#{playlist.id}"
end

delete('/playlists/:id') do
  Playlist.find(params.fetch('id').to_i).destroy
  redirect('/playlists')
end

delete('/playlists/:playlist_id/tags/:id') do
  playlist = Playlist.find(params.fetch('playlist_id').to_i)
  tag = Tag.find(params.fetch('id').to_i)
  playlist.tags.destroy(tag)
  if tag.playlists.empty?
    tag.destroy
  end
  redirect("/playlists/#{playlist.id}")
end

post('/playlists/:id/tags') do
  playlist = Playlist.find(params.fetch('id').to_i)
  new_tags = params.fetch('new-tags')
  Tag.make_all(new_tags).each do |tag|
    unless playlist.tags.find_by_name(tag.name)
      playlist.tags.push(tag)
    end
  end
  redirect "/playlists/#{params.fetch('id').to_i}"
end

get('/playlists/:id/lessons/search') do
  @playlist = Playlist.find(params.fetch('id').to_i)
  @public_lessons = Lesson.all_public.to_a.delete_if{|lesson|
    @playlist.lessons.all_links.include?(lesson.external_link)
  }
  erb(:_lesson_search)
end


post("/playlists/:id/lessons/clone") do
  playlist = Playlist.find(params.fetch("id").to_i)
  template_lesson = Lesson.find(params.fetch("lesson_id").to_i)
  new_lesson = Lesson.new({
    :title => template_lesson.title,
    :description => template_lesson.description,
    :external_link => template_lesson.external_link,
    :is_private => true
  })
  @user.lessons.push(new_lesson)
  playlist.lessons.push(new_lesson)
  redirect "/playlists/#{playlist.id}/lessons/search"
end
