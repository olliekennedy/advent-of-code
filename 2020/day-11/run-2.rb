input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map {|x| x.split("") }

def visualise(input)
  puts "***************"
  input.each do |x|
    puts x.inspect
  end
  puts "***************"
end

def lifer(input)
  output = input.map(&:clone)

  input.each_with_index do |y, i|
    y.each_with_index do |x, j|
      if input[i][j] == "L"
        if surr_occ(input, j, i) == 0
          output[i][j] = "#"
        end
      elsif input[i][j] == "#"
        if surr_occ(input, j, i) >= 5
          output[i][j] = "L"
        end
      end
    end
  end

  if output == input
    return count_hashes(output)
  else
    puts visualise(output)
    return lifer(output)
  end
end

def valid_pos(input, look)
  if look[0] >= input[0].length || look[1] >= input.length || look[0] < 0 || look[1] < 0
    return false
  end
  return true
end

def surr_occ(input, x_pos, y_pos)
  count = 0

  n = 1
  while true do
    look = [x_pos, y_pos - n]
    if !valid_pos(input, look) || input[look[1]][look[0]] == "L"
      break
    end
    if input[look[1]][look[0]] == "#"
      count += 1
      break
    end
    n += 1
  end
  n = 1
  while true do
    look = [x_pos + n, y_pos - n]
    if !valid_pos(input, look) || input[look[1]][look[0]] == "L"
      break
    end
    if input[look[1]][look[0]] == "#"
      count += 1
      break
    end
    n += 1
  end
  n = 1
  while true do
    look = [x_pos + n, y_pos]
    if !valid_pos(input, look) || input[look[1]][look[0]] == "L"
      break
    end
    if input[look[1]][look[0]] == "#"
      count += 1
      break
    end
    n += 1
  end
  n = 1
  while true do
    look = [x_pos + n, y_pos + n]
    if !valid_pos(input, look) || input[look[1]][look[0]] == "L"
      break
    end
    if input[look[1]][look[0]] == "#"
      count += 1
      break
    end
    n += 1
  end
  n = 1
  while true do
    look = [x_pos, y_pos + n]
    if !valid_pos(input, look) || input[look[1]][look[0]] == "L"
      break
    end
    if input[look[1]][look[0]] == "#"
      count += 1
      break
    end
    n += 1
  end
  n = 1
  while true do
    look = [x_pos - n, y_pos + n]
    if !valid_pos(input, look) || input[look[1]][look[0]] == "L"
      break
    end
    if input[look[1]][look[0]] == "#"
      count += 1
      break
    end
    n += 1
  end
  n = 1
  while true do
    look = [x_pos - n, y_pos]
    if !valid_pos(input, look) || input[look[1]][look[0]] == "L"
      break
    end
    if input[look[1]][look[0]] == "#"
      count += 1
      break
    end
    n += 1
  end
  n = 1
  while true do
    look = [x_pos - n, y_pos - n]
    if !valid_pos(input, look) || input[look[1]][look[0]] == "L"
      break
    end
    if input[look[1]][look[0]] == "#"
      count += 1
      break
    end
    n += 1
  end
  return count
end

def count_hashes(input)
  count = 0
  input.each do |x|
    x.each do |y|
      if y == "#"
        count += 1
      end
    end
  end
  return count
end

puts lifer(input).inspect
