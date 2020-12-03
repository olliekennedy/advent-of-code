require 'advent'

RSpec.describe Advent do
  describe '#check' do
    it 'the correct test output' do
      input = File.readlines('./test-input.txt')
      expect(subject.check(input)).to eq 2
    end
  end
end
