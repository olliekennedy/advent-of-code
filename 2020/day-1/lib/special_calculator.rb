class SpecialCalculator
  def find(addends, sum, input=nil)
    nums = arr_of_ints(input)
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

  private

  def arr_of_ints(input)
    input.nil? ? File.readlines('./input.txt').map(&:to_i) : input.split("\n").map(&:to_i)
  end
end
