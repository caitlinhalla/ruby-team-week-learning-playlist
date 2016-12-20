require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
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
  erb(:lesson_detail)
end

post('dasboard/lessons/new') do
  title = params.fetch('lesson_title')
  description = params.fetch('lesson_description')
  link = params.fetch('external_link')
  is_public = params.fetch('is_public')
  @lesson = Lesson.create({:title => title, :description => description, :external_link => external_link, :private => is_public})
  redirect '/lessons/:id'
end
