require 'spec_helper'

describe(Tag) do
  it { should have_and_belong_to_many(:lessons) }
  it { should have_and_belong_to_many(:playlists) }
end

describe '.make_all' do
  it 'will make all of the tags in the comma separated string' do
    Tag.make_all('alpha, beta, gamma')
    expect(Tag.all).to eq [Tag.find_by_name('alpha'), Tag.find_by_name('beta'), Tag.find_by_name('gamma')]
  end
  it 'will make new tags if they don\'t exist and use existing tags if they exist' do
    alpha = Tag.create({:name => "alpha"})
    Tag.make_all('alpha, beta, gamma')
    expect(Tag.all).to eq [alpha, Tag.find_by_name('beta'), Tag.find_by_name('gamma')]
  end
end
