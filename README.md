# _Learning Playlist_

#### By _**Caitlin Ashtari, Kenneth Black, Marty Kovach, Margie Nevarez, Haley Swain**, 12/22/2016_

## Description

Currently, classroom instruction is one-size fits all. Whether in a public elementary school, university lecture, or code school, students are treated as a collective rather than as individuals with different learning styles, interests, and motivations. The goal of this project is to make the learning experience differentiated through a student-teacher created “playlist” or lesson list so that each student’s individual needs are met and every student excels. Includes options for teacher created lessons, or self-directed lessons.


**User Stories**

* As a user, I can add new playlists for me to learn
* As a user, I can edit, update, delete my playlists
* As a user, I can add new lessons to my playlist for me to learn
* As a user, I can edit, update, delete my lessons
* As a user, I can mark my lessons as public so they can be shared
* As a user, I can search public lessons and add them to my list


## Setup/Installation Requirements

* Clone this repo: `git clone git@github.com:lawlietblack/learning-playlist.git`
* Change to the repo directory: `cd learning-playlist`
* Install gems: `bundle install --path vendor/bundle`
* Install the database: *instruction below*
* Run the app: `ruby app.rb`

## Database Setup Instructions

* install and start postgres
* run: `bundle exec rake db:create`
* run: `bundle exec rake db:migrate`
* run: `bundle exec rake db:test:prepare`

## Technologies Used

_Ruby, Sinatra, SQL, Postgres, BCrypt, Warden, Heroku, JavaScript, MaterializeCSS, jQuery_

### License

*MIT License*

Copyright (c) 2016 **_Caitlin Ashtari_**, **_Kenneth Black_**, **_Marty Kovach_**, **_Margie Nevarez_**, **_Haley Swain_**
