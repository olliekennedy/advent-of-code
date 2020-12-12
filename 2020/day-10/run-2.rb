input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i).sort
# puts input.inspect

input.unshift(0)
input << input[-1] + 3

def perms(hash, i, input)
  count = 0
  # puts "Hash = #{hash}"
  # puts "I = #{i}"
  if i == 0
    # return count
    return 1
  end
  if !input.include?(i)
    return 0
    # return false
  end
  puts hash
  # puts hash[i]
  if hash[i].nil?
    # puts calc(hash, i - x, input)
    output = hash[i] = [1,2,3].sum do |x|
      # puts x
      perms(hash, i - x, input)
    end
  else
    output = hash[i]
  end
  # puts count
  return output
end
#
puts perms({}, input[-1], input)
