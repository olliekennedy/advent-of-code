input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }
input = input.map { |x| x.gsub("mem[", "").gsub("] = ", ",").split(",") }

mem = {}

mask = ""

input.each do |x|
  if x[0][0,4] == "mask"
    mask = x[0].slice(7,300).split("")
    next
  end
  bin = '%036b' % x[0]
  mask.each_with_index do |y, i|
    next if y == "0"
    bin[i] = y
  end
  binArr = bin.split("")
  xes = []
  binArr.each_with_index do |y, i|
    xes << i if y == "X"
  end
  perms = [0, 1].repeated_permutation(xes.length).to_a
  addresses = []
  perms.each do |y|
    new_bin = bin.clone
    y.each_with_index do |z, i|
      new_bin[xes[i]] = z.to_s
    end
    addresses.push(new_bin)
  end
  addresses.each do |y|
    mem[y.to_i(2)] = x[1].to_i
  end
end

memArr = mem.values
puts memArr.sum
