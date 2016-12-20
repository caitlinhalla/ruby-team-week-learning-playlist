require('spec_helper')

describe 'User Authentication', :type => :feature do
  before(:each) do
    User.create({:username => "pam", :password => "test"})
  end
  describe 'login' do
    it 'allows an existing user to log in' do
      visit '/'
      fill_in('login-username', :with => "pam")
      fill_in('login-password', :with => 'test')
      click_button('Log In')
      expect(page).to have_content("Successfully logged in. Welcome pam")
    end
    it 'fails to login if user does not exist' do
      visit '/'
      fill_in('login-username', :with => "timmy")
      fill_in('login-password', :with => 'test')
      click_button('Log In')
      expect(page).to have_content("The username you entered does not exist.")
    end
  end
end
