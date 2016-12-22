require('spec_helper')

describe('the add lesson path', {:type => :feature}) do
  it ('it will allow the user to add a lesson to the database') do
    visit('/lessons')
    fill_in('lesson_title', :with => "How to Git Good")
    fill_in('lesson_description', :with => "learn.")
    fill_in('external_link', :with => "Yo.")
    check('is_private')
    click_button('Submit Lesson')
    expect(page).to have_content('How to Git Good')
  end
  it "will add the user relation to the lesson" do
    visit '/auth/register'
    fill_in('user[username]', :with => "pam")
    fill_in('user[password]', :with => 'test')
    fill_in('user[password-repeat]', :with => 'test')
    click_button('Register')
    visit('/lessons')
    fill_in('lesson_title', :with => "How to Git Good")
    fill_in('lesson_description', :with => "learn.")
    fill_in('external_link', :with => "Yo.")
    check('is_private')
    click_button('Submit Lesson')
    expect(page).to have_content('How to Git Good')
    expect(User.find_by_username("pam").lessons).to eq [Lesson.all.first]
  end
end

describe('the view lesson details path', {:type => :feature}) do
  it ('will allow the user the view the details of specific lesson') do
    test_lesson = Lesson.create({:title => "Zebra Scrubbing", :description => "A beginers guide", :external_link => 'link', :is_private => false})
    visit('/lessons')
    click_link('Zebra Scrubbing')
    expect(page).to have_content('A beginers guide')
  end
end

describe("update the lesson details", {:type => :feature}) do
  it('will allow the user to update individual details of a specific lesson') do
    test_lesson = Lesson.create({:title => "Zebra Scrubbing", :description => "A beginers guide", :external_link => 'link', :is_private => false})
    visit('/lessons')
    click_link('Zebra Scrubbing')
    fill_in('lesson_title', :with => "How to Git Good")
    fill_in('lesson_description', :with => "learn.")
    fill_in('external_link', :with => "Yo.")
    check('is_private')
    click_button('Update Lesson')
    expect(page).to have_content("How to Git Good")
  end
end

describe("delete single lesson", {:type => :feature}) do
  it("delete a lesson from the database") do
    test_lesson = Lesson.create({:title => "Zebra Scrubbing", :description => "A beginers guide", :external_link => 'link', :is_private => false})
    visit('/lessons')
    click_link("Zebra Scrubbing")
    click_button('Delete')
    expect(page).to have_content("There are no lessons. Add them with the form below")
  end
end

describe('the add tag to a lesson path', {:type => :feature}) do
  it ('it will allow the user to add a tag to an existing lesson') do
    visit('/lessons')
    fill_in('lesson_title', :with => "How to Git Good")
    fill_in('lesson_description', :with => "learn.")
    fill_in('external_link', :with => "Yo.")
    check('is_private')
    click_button('Submit Lesson')
    click_link("How to Git Good")
    fill_in('new-tags', :with => "cool")
    click_button('Add Tags!')
    expect(page).to have_content("cool")
  end
end

describe('the delete tag to a lesson path', {:type => :feature}) do
  it ('it will allow the user to delete a tag from an existing lesson') do
    test_lesson = Lesson.create({:title => "Zebra Scrubbing", :description => "A beginers guide", :external_link => 'link', :is_private => false})
     test_tag = Tag.create({:name => "meat"})
     test_lesson.tags.push(test_tag)
     visit "/lessons/#{test_lesson.id}"
     find("#tag-remove-#{test_tag.id}").click
     expect(page).to have_content("link")
     expect(page).not_to have_content("meat")
   end

  it "deletes the tag if it has no remaining lessons" do
    test_lesson = Lesson.create({:title => "Zebra Scrubbing", :description => "A beginers guide", :external_link => 'link', :is_private => false})
    test_tag = Tag.create({:name => "cool"})
    test_lesson.tags.push(test_tag)
    visit "/lessons/#{test_lesson.id}"
    find("#tag-remove-#{test_tag.id}").click
    expect(Tag.find_by_name(test_tag.name)).to eq nil
  end


  it "deletes the tag if it has no remaining recipes" do
    test_lesson = Lesson.create({:title => "Zebra Scrubbing", :description => "A beginers guide", :external_link => 'link', :is_private => false})
    test_tag = Tag.create({:name => "cool"})
    test_lesson.tags.push(test_tag)
    visit "/lessons/#{test_lesson.id}"
    find("#tag-remove-#{test_tag.id}").click
    expect(Tag.find_by_name(test_tag.name)).to eq nil
    end
end
