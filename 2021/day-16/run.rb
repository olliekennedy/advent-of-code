input = File.read('./test-input.txt').chomp#.map{ |x| x.gsub("\n", "") }#.map(&:to_i)
puts input.inspect

mapping = {
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
bin = input.split("").map { |x| mapping[x] }.join("")
p "Bin = #{bin}"
puts

@version_numbers = []

def process(bin)
  return if bin.to_i(2) == 0
  packet_version = bin.slice(0, 3)
  p "Packet Version: #{packet_version} - #{packet_version.to_i(2)}"
  @version_numbers << packet_version.to_i(2)
  p "Adding version number to arr: #{packet_version.to_i(2)}"

  packet_type_id = bin.slice(3, 3)
  p "Packet Type ID: #{packet_type_id} - #{packet_type_id.to_i(2)}"

  binary_to_check = bin[6..-1]
  p "Binary to check: #{binary_to_check}"

  if packet_type_id.to_i(2) == 4
    p "Packet Type ID is 4 so calculating literal"
    literal_value = ""
    finished = false
    bin_arr = binary_to_check.split("")
    until finished
      p "Literal value: #{literal_value}"
      p "bin_arr: #{bin_arr.join("")}"
      break if bin_arr.length < 5
      to_work_on = bin_arr.shift(5)
      p "To work on:"
      p to_work_on
      if to_work_on[0] == "0"
        p "FINISHING!"
        finished = true
      end
      literal_value += to_work_on[1..4].join("")
    end

    p "Literal value: #{literal_value}"
    answer = literal_value.to_i(2)
    p "Answer: #{answer}"
    # @version_numbers << packet_version.to_i(2)
    p "Adding version number to arr: #{packet_version.to_i(2)}"
    if bin_arr.length > 10
      process(bin_arr.join(""))
    end
  else
    p "Packet Type ID is not 4 so working out length type ID"
    length_type_id = binary_to_check[0]
    binary_to_check = binary_to_check[1..-1]
    if length_type_id == "0"
      p "Length type ID is 0 so working out total length of sub packets"
      length_of_sub_packets_in_binary = binary_to_check[0...15]
      length_of_sub_packets = binary_to_check[0...15].to_i(2)
      p "Length of sub packets in binary: #{length_of_sub_packets_in_binary}"
      p "Length of sub packets: #{length_of_sub_packets}"
      p "Passing #{binary_to_check.slice(15, length_of_sub_packets)} to process"
      binary_to_check_without_length = binary_to_check[15..-1]
      process(binary_to_check_without_length[0...length_of_sub_packets])
    elsif length_type_id == "1"
      p "Length Type ID is 1 so working out number of sub packets"
      number_of_sub_packets = binary_to_check[0...11].to_i(2)
      p "Number of sub packets: #{number_of_sub_packets}"
      # chunk_size = 11
      # p "Chunk Size: #{chunk_size}"

      p "Passing #{binary_to_check[11..-1]} to process"
      process(binary_to_check[11..-1])

      # binary_to_check[11..-1].split("").each_slice(chunk_size) do |x|
      #   break if x.length < chunk_size
      #   p "Passing #{x.join("")} to process"
      #   process(x.join(""))
      # end
    else
      p "THERE'S AN ERROR"
    end
  end
end

process(bin)

puts "Sum of version numbers: #{@version_numbers.sum}"
