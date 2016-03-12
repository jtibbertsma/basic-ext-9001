require 'basic-ext-9001'

RSpec.describe BasicExt9001::Guts do
  before(:each) do
    @guts = BasicExt9001::Guts.new 9001
    @guts2 = BasicExt9001::Guts.new 9002
  end

  it "doesn't explode" do
    expect(@guts.var).to eq(9001)
    @guts.var = 42
    expect(@guts.var).to eq(42)
  end

  it "allows you to set the same ivar on multiple objects" do
    @guts.var = 42
    @guts2.var = 44
    expect(@guts.var).to eq(42)
    expect(@guts2.var).to eq(44)
  end
end