calories = File.readlines("calories.txt")
calories.map!(&:to_i)

calories_by_elf = []
elf_calories = []

calories.each do |c|
    if c == 0
        calories_by_elf << elf_calories
        elf_calories = []
    end

    elf_calories << c
end
calories_by_elf << elf_calories

sorted_calorie_totals = calories_by_elf.map(&:sum).sort

total_of_top_three = sorted_calorie_totals.last(3).sum

puts "Total of top three elf calories: #{total_of_top_three}"

