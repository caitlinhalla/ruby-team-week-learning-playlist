require('spec_helper')

describe(User) do
  it { should have_many(:playlists) }
  
  describe("authentication") do
    it("will create a user") do
      user = User.new(:username => "Krieger")
      user.password = "Guest"
      user.save!
      expect(user.password.class).to eq BCrypt::Password
    end
    it("creates a user when provided username and password") do
      user = User.new({:username => "Krieger", :password => "Guest"})
      user.save!
      expect(user.password.class).to eq BCrypt::Password
    end
    it("can make new users and save them with .create") do
      user = User.create({:username => "Krieger", :password => "Guest"})
      expect(user.password.class).to eq BCrypt::Password
    end
  end
  describe '#lessons_completed' do
    before(:each) do
      user = User.create({:username => "guest", :password => "test"})
      playlist = Playlist.create({})
    end
    it "should return an array of lessons completed" do

    end
  end
end
