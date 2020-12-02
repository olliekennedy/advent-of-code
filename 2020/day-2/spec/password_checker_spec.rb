require 'password_checker'

RSpec.describe PasswordChecker do
  describe '#check' do
    it 'returns the number of passwords that meet the crit' do
      input = File.readlines('./test-input.txt')
      expect(subject.check(input)).to eq 2
    end
    it 'returns the number of passwords that meet the real' do
      input = File.readlines('./input.txt')
      expect(subject.check(input)).to eq 607
    end
  end
  describe '#check2' do
    it 'returns correctly for the example' do
      input = File.readlines('./test-input.txt')
      expect(subject.check2(input)).to eq 1
    end
  end
end
