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
    it "validates the presence of lesson title" do
      lesson = Lesson.create({:title => ""})
      expect(lesson.save).to(eq(false))
    end
    it "validates the presence of lesson description" do
      lesson = Lesson.create({:description=> ""})
      expect(lesson.save).to(eq(false))
    end
    it "validates the presence of lesson external link" do
      lesson = Lesson.create({:external_link => ""})
      expect(lesson.save).to(eq(false))
    end
  end
    describe "#url" do
      it "will check to see if the link includeds 'https://www.', if false it will be added to the link." do
        lesson = Lesson.create({:title => "Rails", :description => "It's off the rails", :external_link => "learnhowtoprogram.com"})
        expect(lesson.url).to eq("https://www.learnhowtoprogram.com")
    end
  end
end
