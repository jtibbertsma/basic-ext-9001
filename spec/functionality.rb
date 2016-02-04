require 'basic-ext-9001'

RSpec.describe BasicExt9001::Guts do
  before :each do
    @guts = BasicExt9001::Guts.new
  end
  let(:err) { BasicExt9001::GutsError }

  describe '#push' do
    it 'should throw an error when full' do
      @guts.push(nil) until @guts.full?
      expect { @guts.push nil }.to raise_error(err)
    end

    it 'works together with #pop' do
      third = Object.new
      @guts.push nil
      @guts.push nil
      @guts.push third
      @guts.push nil
      @guts.pop

      expect(@guts.pop).to eq(third)
    end
  end

  describe '#pop' do
    it 'should throw an error when empty' do
      expect { @guts.pop }.to raise_error(err)
    end
  end

  describe '#size' do
    it 'reports the correct size' do
      7.times { @guts.push nil }
      expect(@guts.size).to eq(7)
    end

    it 'is aliased to length' do
      7.times { @guts.push nil }
      expect(@guts.length).to eq(7)
    end
  end
end