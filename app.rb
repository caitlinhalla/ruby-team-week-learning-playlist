require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require("pry")
require('./lib/lesson')
require('./lib/playlist')
require('./lib/student')
require('./lib/user')
require('./lib/tag')

get('/') do
  erb(:index)
end

post('/login') do
  redirect '/dashboard'
end

get('/dashboard') do
  erb(:student_dashboard)
end

get('/lessons') do
  @lessons = Lesson.all
  erb(:lesson_list)
end

get('/lesson_detail/:id') do
  @lesson = Lesson.find(params.fetch('id').to_i)
  @tags = Tag.all()

  erb(:lesson_detail)
end

post('/lessons') do
  title = params.fetch('lesson_title')
  description = params.fetch('lesson_description')
  link = params.fetch('external_link')
  is_private = params.has_key?('is_private')
  @lesson = Lesson.create({:title => title, :description => description, :external_link => link, :is_private => is_private})
  redirect '/lessons'
end

patch('/lessons/:id') do
  @lesson = Lesson.find(params.fetch('id').to_i)
  title = params.fetch('lesson_title')
  description = params.fetch('lesson_description')
  link = params.fetch('external_link')
  is_private = params.has_key?('is_private')
  @lesson.update({:title => title, :description => description, :external_link => link, :is_private => is_private})
  redirect "/lesson_detail/#{params.fetch('id').to_i}"
end

delete('/lessons/:id') do
  @lesson = Lesson.find(params.fetch('id').to_i)
  @lesson.destroy()
  @lessons = Lesson.all()
  redirect '/lessons'
end

post('/lessons/:id/tags') do

  @lesson = Lesson.find(params.fetch('id').to_i)
  new_tags = params.fetch('new-tags')
  Tag.make_all(new_tags).each do |tag|
    unless @lesson.tags.find_by_name(tag.name)
      @lesson.tags.push(tag)
    end
  end
  redirect "/lesson_detail/#{params.fetch('id').to_i}"
end
