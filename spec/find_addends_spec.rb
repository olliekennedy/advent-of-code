require 'find_addends'

RSpec.describe FindAddends do
  describe '#find' do
    it 'returns the product of the two addends based on input of 2020' do
      expect(subject.find('1721
979
366
299
675
1456', 2, 2020)).to eq 514579
    end
    it 'returns the product of the three addends based on input of 2020' do
      expect(subject.find('1721
979
366
299
675
1456', 3, 2020)).to eq 241861950
    end
  end
end
