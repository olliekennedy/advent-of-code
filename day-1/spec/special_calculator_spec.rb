require 'special_calculator'

RSpec.describe SpecialCalculator do
  describe '#find' do
    it 'returns the product of the two addends based on input of 2020' do
      expect(subject.find(2, 2020, '1721
979
366
299
675
1456')).to eq 514579
    end
    it 'returns the product of the three addends based on input of 2020' do
      expect(subject.find(3, 2020, '1721
979
366
299
675
1456')).to eq 241861950
    end
  end
end
