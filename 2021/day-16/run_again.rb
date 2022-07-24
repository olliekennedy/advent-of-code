raw_hex_input = File.read('./test-input.txt')
puts "raw_hex_input = #{raw_hex_input.inspect}"

BIN_FROM_HEX = {
  "0" => "0000",
  "1" => "0001",
  "2" => "0010",
  "3" => "0011",
  "4" => "0100",
  "5" => "0101",
  "6" => "0110",
  "7" => "0111",
  "8" => "1000",
  "9" => "1001",
  "A" => "1010",
  "B" => "1011",
  "C" => "1100",
  "D" => "1101",
  "E" => "1110",
  "F" => "1111"
}

raw_binary_input = raw_hex_input.split("").map{ |x| BIN_FROM_HEX[x] }.join("")
puts "raw_binary_input = #{raw_binary_input}"

def is_literal_packet?(packet_type_id)
  packet_type_id.to_i(2) == 4
end

def process_literals(input)
  useful_bits = ""
  unused_bits = ""
  (0...(input.length-4)).each do |x|
    next unless x % 5 == 0
    to_process = input[x,5]
    useful_bits += to_process[1,4]
    if to_process[0] == "0"
      unused_bits += input[(x+5)..-1]
      puts "Literals processed. Output = #{useful_bits}, #{useful_bits.to_i(2)}"
      return { "useful_bits" => useful_bits, "unused_bits" => unused_bits }
    end
  end
  puts "ERROR"
  return
end

def process_lengthy(input)
  length_of_all_sub_packets = input[0,15].to_i(2)
  puts "length_of_all_sub_packets = #{length_of_all_sub_packets}"
  processed_lengthy = process(input[15, length_of_all_sub_packets])
  processed_lengthy["unused_bits"] = input[(15 + length_of_all_sub_packets)..-1]
  return processed_lengthy
end

def process_numbery(input)
  number_of_packets = input[0,11]
  puts "number_of_packets = #{number_of_packets}, #{number_of_packets.to_i(2)}"
  return process(input[11..-1], number_of_packets.to_i(2))
end

def process_operator(input)
  length_type_id = input[0]
  puts "length_type_id = #{length_type_id}"

  if length_type_id == "0"
    processed_lengthy = process_lengthy(input[1..-1])
    return processed_lengthy
  else
    return process_numbery(input[1..-1])
  end

end

def process(input, number=100000000000)
  output = Hash.new("")
  packet_version = input[0,3]
  puts "packet_version = #{packet_version}, #{packet_version.to_i(2)}"
  output["packet_versions"] = [packet_version.to_i(2)]
  packet_type_id = input[3,3]
  puts "packet_type_id = #{packet_type_id}, #{packet_type_id.to_i(2)}"

  if is_literal_packet?(packet_type_id)
    processed_literals = process_literals(input[6..-1])
    output["useful_bits"] = processed_literals["useful_bits"]
    output["unused_bits"] = processed_literals["unused_bits"]
  else
    processed_operator = process_operator(input[6..-1])
    output["packet_versions"] += processed_operator["packet_versions"]
    output["unused_bits"] += processed_operator["unused_bits"]
  end

  if output["unused_bits"].length >= 11 && number > 1
    puts "number left = #{number - 1}"
    processed = process(output["unused_bits"], number - 1)
    output["packet_versions"] += processed["packet_versions"]
  end

  output["unused_bits"] = ""
  return output
end

answer = process(raw_binary_input)
puts answer.inspect
puts "version sum = #{answer["packet_versions"].sum}"

