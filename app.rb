require("bundler/setup")
Bundler.require(:default)
require('./helpers/session')

require_all('lib')

before do
  @user = env['warden'].user rescue env['warden'].logout
end

require_all('routes')

get('/') do
  erb(:index)
end

get('/dashboard') do
  @playlists = Playlist.all
  @playlist = Playlist.all.first
  @playlists = @user.playlists if env['warden'].user
  @playlist = @user.playlists.first if env['warden'].user
  erb(:dashboard)
end
