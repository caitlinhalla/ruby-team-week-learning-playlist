require('spec_helper')

describe Playlist do
  it { should have_and_belong_to_many(:lessons)}
  it { should belong_to(:student)}
end
