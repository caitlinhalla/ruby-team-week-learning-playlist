require('spec_helper')

describe Student do
  it { should have_many(:playlists) }
end
