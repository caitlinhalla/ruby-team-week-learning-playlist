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

get('/') do
  erb(:index)
end

post('/login') do
  redirect '/dashboard'
end

get('/dashboard') do
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
