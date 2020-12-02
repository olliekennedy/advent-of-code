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
  # def find(input, addends, sum)
  #   if addends == 2
  #     arr_of_ints(input).each do |x|
  #       if arr_of_ints(input).include?(sum - x)
  #         return x * (sum - x)
  #       end
  #     end
  #   end
  # end

  private

  def arr_of_ints(input)
    if !input.nil?
      return input.split("\n").map(&:to_i)
    else
      File.readlines('./input.txt').map(&:to_i)
    end
  end
end
