# require('benchmark')

@sorted_adapters = File.readlines('./input.txt').map(&:chomp).map(&:to_i).sort.unshift(0)
@sorted_adapters << @sorted_adapters[-1] + 3

def perms(hash, i)
  # indicate that the branch is invalid by not adding to the total
  return 0 if !@sorted_adapters.include?(i)

  # indicate that the branch is valid by adding 1 to the total...
  # ...this will manifest itself by being included in the sum further down
  return 1 if i == 0

  # return the hash value (sum) for that number if it exists...
  # ...meaning that you don't have to evaluate that figure again...
  # ...since it already has been evaluated and added to the hash
  # OR
  # try out i-1, i-2 and i-3
  hash[i] ||= [1,2,3].sum { |x| perms(hash, i - x) }
end

puts perms({}, @sorted_adapters[-1])
