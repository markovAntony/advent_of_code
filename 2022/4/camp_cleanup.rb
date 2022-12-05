assignments = File.readlines("assignments.txt")

def expand_range(sections)
    range = sections.split("-")
    [*range[0]..range[1]]
end

def inclusive?(a, b)
    (b - a).empty? || (a - b).empty?
end

def any_overlap?(a, b)
    (a & b).count != 0
end

sum_range_contained_part_1 = 0
assignments.map do |assignment|
    sections = assignment.chomp.split(",")
    sections.map! { |s| expand_range(s) }

    sum_range_contained_part_1 += inclusive?(sections[0], sections[1]) ? 1 : 0
end

sum_range_contained_part_2 = 0
assignments.map do |assignment|
    sections = assignment.chomp.split(",")
    sections.map! { |s| expand_range(s) }

    sum_range_contained_part_2 += any_overlap?(sections[0], sections[1]) ? 1 : 0
end

puts "(Part 1) There are #{sum_range_contained_part_1} pairs with overlapping ranges"
puts "(Part 2) There are #{sum_range_contained_part_2} pairs with overlapping ranges"

