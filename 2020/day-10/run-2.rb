require 'benchmark'

@sorted_adapters = File.readlines('./input.txt').map(&:chomp).map(&:to_i).sort.unshift(0)
@sorted_adapters << @sorted_adapters.last + 3
@sorted_adapters.map { |x| [x, nil]}.to_h

def perms(hash, i)
  return 0 if !@sorted_adapters.include?(i)
  return 1 if i == @sorted_adapters.last
  hash[i] ||= [1,2,3].sum { |x| perms(hash, i + x) }
end

adapters = File.readlines('./input.txt').map(&:to_i).sort.unshift(0)
dummy_vals = [true] * adapters.length
adapters_hash = adapters.zip(dummy_vals).to_h
current_joltage = 0
MAX_JOLTAGE = adapters.last
def permutations(joltage, completed_paths, adapters_hash)
  if completed_paths[joltage]
    return completed_paths[joltage]
  elsif joltage == MAX_JOLTAGE
    return 1
  elsif !adapters_hash[joltage]
    return 0
  else
    completed_paths[joltage] = [1,2,3].sum do |increase|
      permutations(joltage + increase, completed_paths, adapters_hash)
    end
  end
end

Benchmark.bm(1) do |x|
  x.report("Ollies:") { perms({}, 0) }
  x.report("Eddies:") { permutations(current_joltage, {}, adapters_hash) }
end
