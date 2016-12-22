get('/lessons') do
  @playlists = Playlist.all
  @lessons = Lesson.all
  @lessons = @user.lessons if env['warden'].user
  @playlists = @user.playlists if env['warden'].user
  erb(:lesson_list)
end

get('/lessons/:id') do
  @lesson = Lesson.find(params.fetch('id').to_i)
  @playlists = Playlist.all
  @playlists = @user.playlists if env['warden'].user
  erb(:lesson_detail)
end

post('/lessons') do
  title = params.fetch('lesson_title')
  description = params.fetch('lesson_description')
  link = params.fetch('external_link')
  is_private = params.has_key?('is_private')
  new_lesson = Lesson.create({:title => title, :description => description, :external_link => link, :is_private => is_private})
  if new_lesson.save
    if params.has_key?('playlist_id')
        playlist = Playlist.find(params.fetch('playlist_id').to_i)
        new_lesson.playlists.push(playlist)
      end
      new_tags = params.fetch('new-tags')
      Tag.make_all(new_tags).each do |tag|
          new_lesson.tags.push(tag)
      end
      env['warden'].user.lessons.push(new_lesson) if env['warden'].user
      redirect '/lessons'
  else
  flash[:error] = "Title, Description, and Source cannot be blank!"
  redirect '/lessons'
  end
end

patch('/lessons/:id') do
  lesson = Lesson.find(params.fetch('id').to_i)
  title = params.fetch('lesson_title')
  description = params.fetch('lesson_description')
  link = params.fetch('external_link')
  is_private = params.has_key?('is_private')
  lesson.update({:title => title, :description => description, :external_link => link, :is_private => is_private})
  redirect "/lessons/#{params.fetch('id').to_i}"
end

delete('/lessons/:id') do
  Lesson.find(params.fetch('id').to_i).destroy
  redirect '/lessons'
end

post('/lessons/:id/tags') do
  lesson = Lesson.find(params.fetch('id').to_i)
  new_tags = params.fetch('new-tags')
  Tag.make_all(new_tags).each do |tag|
    unless lesson.tags.find_by_name(tag.name)
      lesson.tags.push(tag)
    end
  end
  redirect "/lessons/#{params.fetch('id').to_i}"
end

delete('/lessons/:lesson_id/tags/:id') do
  lesson = Lesson.find(params.fetch('lesson_id').to_i)
  tag = Tag.find(params.fetch('id').to_i)
  lesson.tags.destroy(tag)
  # check project tags, too
  if tag.lessons.empty?
    tag.destroy
  end
  redirect("/lessons/#{lesson.id}")
end
