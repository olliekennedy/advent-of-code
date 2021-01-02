require 'benchmark'
adapters = File.readlines('./input.txt').map(&:to_i).sort.unshift(0)
dummy_vals = [true] * adapters.length
adapters_hash = adapters.zip(dummy_vals).to_h
current_joltage = 0
MAX_JOLTAGE = adapters.last
def permutations(joltage, adapters_hash)
  if joltage == MAX_JOLTAGE
    return 1
  elsif !adapters_hash[joltage]
    return 0
  else
    [1,2,3].sum do |increase|
      permutations(joltage + increase, adapters_hash)
    end
  end
end
puts Benchmark.measure {permutations(current_joltage, adapters_hash)}
