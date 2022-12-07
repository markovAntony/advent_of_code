commands = File.readlines("commands.txt", chomp: true)

dirs = {}

commands.each_with_object([]) do |line, arr|
    case
    when line.include?("$ cd ..")
        arr.pop
    when line.include?("$ cd ")
        folder = line.split("$ cd ")[1]
        new_value = [arr.last, folder].compact.join(" ")

        arr.push(new_value)
    when line.split[0].match?(/^\d+$/)
        size = line.split[0].to_i

        arr.each do |e|
            if dirs[e].nil?
                dirs[e] = size
            else
                dirs[e] += size
            end
        end
    end
end

answer_part_1 = dirs.values.reject { |v| v > 100000 }.sum
answer_part_2 = dirs.values.reject do |v|
    v < dirs["/"] - 40000000
end
answer_part_2 = answer_part_2.min

puts "(Part 1) Answer is #{answer_part_1}"
puts "(Part 2) Answer is #{answer_part_2}"
