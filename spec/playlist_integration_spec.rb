require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a playlist', :type => :feature) do
  it ('allows a user to create a playlist') do
    visit('/playlists')
    fill_in('playlist_name', :with => 'Java Lessons')
    fill_in('due_date', :with =>"2016-12-06")
    fill_in('playlist_description', :with => 'There is alot')
    page.check('private')
    click_button('Submit Playlist')
    expect(page).to have_content('Java Lessons')
  end

  it('allows a user to update a playlist') do
    playlist = Playlist.create({:name => 'Happy Playlist', :description => "happy", :due_date => '2016-12-12'})
    visit("/playlists/#{playlist.id}")
    fill_in('playlist_name', :with => 'Sad Playlist')
    click_button('Update')
    expect(page).to have_content('Sad Playlist')
  end

  it('allows a user to delete a playlist') do
    playlist = Playlist.create({:name => 'Happy Playlist', :description => "happy", :due_date => '2016-12-12'})
    visit("/playlists/#{playlist.id}")
    click_button('Delete Playlist')
    expect(page).not_to have_content('Happy Playlist')
  end
end
