require 'basic-ext-9001'

RSpec.describe BasicExt9001::Guts do
  before(:each) do
    @guts = BasicExt9001::Guts.new 9001
  end

  it "doesn't explode" do
    expect(@guts.var).to eq(9001)
    @guts.var = 42
    expect(@guts.var).to eq(42)
  end
end