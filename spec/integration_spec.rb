require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the add lesson path', {:type => :feature}) do
  it ('it will allow the user to add a lesson to the database') do
    visit('/dashboard/lessons')
    fill_in('lesson_title', :with => "How to Git Good")
    fill_in('lesson_description', :with => "learn.")
    fill_in('external_link', :with => "Yo.")
    check('is_private')
    click_button('Submit Lesson')
    expect(page).to have_content('How to Git Good')
  end
end

describe('the view lesson details path', {:type => :feature}) do
  it ('will allow the user the view the detials of specific lesson') do
    test_lesson = Lesson.create({:title => "Zebra Scrubbing", :description => "A beginers guide", :external_link => 'link', :is_private => false})
    visit('/dashboard/lessons')
    click_link('Zebra Scrubbing')
    expect(page).to have_content('A beginers guide')
  end
end

describe("update the lesson details", {:type => :feature}) do
  it('will allow the user to update individual details of a specific lesson') do
    test_lesson = Lesson.create({:title => "Zebra Scrubbing", :description => "A beginers guide", :external_link => 'link', :is_private => false})
    visit('/dashboard/lessons')
    click_link('Zebra Scrubbing')
    fill_in('lesson_title', :with => "How to Git Good")
    fill_in('lesson_description', :with => "learn.")
    fill_in('external_link', :with => "Yo.")
    check('is_private')
    click_button('Update Lesson')
    expect(page).to have_content("How to Git Good")
  end
end
