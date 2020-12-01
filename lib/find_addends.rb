class FindAddends
  def find(input, addends, sum)
    nums = input.split("\n").map { |str| str.to_i }
    nums.each do |i|
      nums.each do |j|
        if addends > 2
          nums.each do |k|
            return i * j * k if i + j + k == sum
          end
        else
          return i * j if i + j == sum
        end
      end
    end
  end
end
