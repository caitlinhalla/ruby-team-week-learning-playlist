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
  describe 'playlists and lessons' do
    before(:all) do
      @user = User.create({:username => "guest", :password => "test"})
      @playlist = Playlist.create({:name => "Ruby"})
      @lesson1 = Lesson.create({:title => "Ruby Basics"})
      @lesson2 = Lesson.create({:title => "Object Oriented Ruby", :complete => true})
      @playlist.lessons.push(@lesson1)
      @playlist.lessons.push(@lesson2)
      @user.playlists.push(@playlist)
    end
    describe '#lessons' do
      it "should return an array of lessons completed" do
        expect(@user.lessons).to eq [@lesson1, @lesson2]
      end
      it "should be able to use Lesson.all_completed" do
        expect(@user.completed_lessons).to eq [@lesson2]
      end
    end


  end
end
