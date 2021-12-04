input = File.read('./input.txt').gsub("\n", "").split(",").map(&:to_i)
# puts input.inspect


(0..input.length).each do |x|
  (0..input.length).each do |y|

    memory = input.clone

    memory[1] = x
    memory[2] = y

    instruction_pointer = 0
    while true do
      opcode = memory[instruction_pointer]
      if opcode == 99
        puts memory[0]
        if memory[0] == 19690720
          puts "Great success!"
          puts x.to_s + y.to_s
          exit
        end
        break
      end

      parameter1 = memory[instruction_pointer + 1]
      parameter2 = memory[instruction_pointer + 2]
      position = memory[instruction_pointer + 3]

      if parameter1 >= memory.length || parameter2 >= memory.length || position >= memory.length
        break
      end

      case opcode
      when 1
        memory[position] = memory[parameter1] + memory[parameter2]
        instruction_pointer+=4
      when 2
        memory[position] = memory[parameter1] * memory[parameter2]
        instruction_pointer+=4
      when 3
        memory[parameter1]
      when 99
        break
      end
    end

  end
end


