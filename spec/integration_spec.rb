require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the add lesson path', {:type => :feature}) do
  it ('it will allow the user to add a lesson to the database') do
    visit('/dashboard/lessons')
    fill_in('lesson_title', :with => "How to Git Good.")
    fill_in('lesson_description', :with => "learn.")
    fill_in('external_link', :with => "Yo.")
    check('is_public')
    click_button('Submit Lesson')
    expect(page).to have_content('How to Git Good')
  end
end
