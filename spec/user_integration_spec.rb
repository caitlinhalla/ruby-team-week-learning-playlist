require('spec_helper')

describe 'User Authentication', :type => :feature do
  before(:each) do
    User.create({:username => "pam", :password => "test"})
  end
  describe 'login' do
    it 'allows an existing user to log in' do
      visit '/auth/login'
      fill_in('user[username]', :with => "pam")
      fill_in('user[password]', :with => 'test')
      click_button('Log In')
      expect(page).to have_content("Successfully logged in. Welcome pam")
    end
    it 'fails to login if user does not exist' do
      visit '/auth/login'
      fill_in('user[username]', :with => "timmy")
      fill_in('user[password]', :with => 'test')
      click_button('Log In')
      expect(page).to have_content("The username you entered does not exist.")
    end
    it 'fails to login if the user enters a bad password' do
      visit '/auth/login'
      fill_in('user[username]', :with => "pam")
      fill_in('user[password]', :with => 'password')
      click_button('Log In')
      expect(page).to have_content("The username and password combination you entered is invalid.")
    end
  end
  describe 'register' do
    it 'allows a user to register' do
      visit '/auth/register'
      fill_in('user[username]', :with => "archer")
      fill_in('user[password]', :with => 'test')
      fill_in('user[password-repeat]', :with => 'test')
      click_button('Register')
      expect(page).to have_content "Registration Successful. Welcome archer"
    end
    it 'fails to register if the user already exists' do
      visit '/auth/register'
      fill_in('user[username]', :with => "pam")
      fill_in('user[password]', :with => 'test')
      fill_in('user[password-repeat]', :with => 'test')
      click_button('Register')
      expect(page).to have_content "A user with that username already exists"
    end
    it 'fails to register if the passwords do not match' do
      visit '/auth/register'
      fill_in('user[username]', :with => "pam")
      fill_in('user[password]', :with => 'test')
      fill_in('user[password-repeat]', :with => 'text')
      click_button('Register')
      expect(page).to have_content "Your passwords must match"
    end
  end
  describe 'logout' do
    it "allows the user to log out" do
      visit '/auth/login'
      fill_in('user[username]', :with => "pam")
      fill_in('user[password]', :with => 'test')
      click_button('Log In')
      expect(page).to have_content("Successfully logged in. Welcome pam")
      visit('/auth/logout')
      expect(page).to have_content("Successfully logged out")
    end
  end
  describe 'delete user' do
    it "allows the user to delete their account" do
      visit '/auth/login'
      fill_in('user[username]', :with => "pam")
      fill_in('user[password]', :with => 'test')
      click_button('Log In')
      expect(page).to have_content("Successfully logged in. Welcome pam")
      visit('/account')
      click_button('Delete My Account')
      expect(page).to have_content "Account Deleted."
    end
  end
  describe 'account' do
    before(:each) do
      visit '/auth/login'
      fill_in('user[username]', :with => "pam")
      fill_in('user[password]', :with => 'test')
      click_button('Log In')
    end
    it 'allows me to see my name on my profile page' do
      visit('/account')
      expect(page).to have_content "pam"
    end
  end
end
