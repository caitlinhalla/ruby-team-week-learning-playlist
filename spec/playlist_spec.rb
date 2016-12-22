require('spec_helper')

describe Playlist do
  it { should have_and_belong_to_many(:lessons) }
  it { should have_and_belong_to_many(:tags) }
  it { should have_and_belong_to_many(:users) }

  describe '#init' do
    it "sets is_private to false if not provided" do
      playlist = Playlist.create({:name => "Ruby"})
      expect(playlist.is_private).to eq false
    end
    it "sets completed to false if not provided" do
      playlist = Playlist.create({:name => "Ruby"})
      expect(playlist.complete).to eq false
    end
  end
end
