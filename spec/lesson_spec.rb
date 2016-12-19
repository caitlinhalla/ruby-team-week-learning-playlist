require('spec_helper')

describe Lesson do
  it { should have_and_belong_to_many(:playlists)}
end
