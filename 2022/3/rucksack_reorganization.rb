items = File.readlines("items.txt")

def find_priority(letter)
    letters = [*"a".."z"] + [*"A".."Z"]

    letters.index(letter) + 1
end

def split_components(components)
    components.scan(/.{1,#{components.size / 2 - 1}}./)
end

items.map! { |c| split_components(c) }

sum_priorities_part_1 = 0
items.each do |item|
    common_item = (item[0].chars & item[1].chars)[0]
    sum_priorities_part_1 += find_priority(common_item)
end

sum_priorities_part_2 = 0
items.each_slice(3) do |group|
    rucksacks = group.map(&:join)

    common_item = (rucksacks[0].chars & rucksacks[1].chars & rucksacks[2].chars)[0]
    sum_priorities_part_2 += find_priority(common_item)
end

puts "Sum of priorities (part 1) is #{sum_priorities_part_1}"
puts "Sum of priorities (part 2) is #{sum_priorities_part_2}"

