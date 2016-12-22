require('spec_helper')

describe Lesson do
  it { should have_and_belong_to_many(:playlists) }
  it { should have_and_belong_to_many(:users) }

  describe '#init' do
    it "sets is_private to false if not provided" do
      lesson = Lesson.create({:title => "Ruby"})
      expect(lesson.is_private).to eq false
    end
    it "sets completed to false if not provided" do
      lesson = Lesson.create({:title => "Ruby"})
      expect(lesson.complete).to eq false
    end
  end
end
