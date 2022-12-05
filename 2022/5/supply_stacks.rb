drawing = File.readlines("drawing.txt")

def deep_copy(o)
    Marshal.load(Marshal.dump(o))
end

def get_crate_stacks(drawing)
    numbers = drawing.find { |i| i.start_with?(" 1") }.chomp
    keys = numbers.split.map(&:to_i)

    crates = {}
    col_idx = 1

    keys.each do |key|
        crates[key] = []
        drawing.each do |line|
            break if line.start_with?(" 1")

            crates[key] << line[col_idx] unless line[col_idx] == " "
        end

        crates[key].reverse!
        col_idx += 4
    end

    crates
end

def get_moves(drawing)
    moves = []

    drawing.each do |line|
        if line.start_with?("move")
            move = line.gsub("move", "").gsub("from", "").gsub("to", "")
            moves << move.split.map(&:to_i)
        end
    end

    moves
end

def rearrange(crates, moves, retain_order=false)
    rearranged_crates = deep_copy(crates)

    moves.each do |move|
        number_of_crates = move[0]
        from = move[1]
        to = move[2]

        if retain_order
            moving_crates = rearranged_crates[from].pop(number_of_crates)
            rearranged_crates[to].concat(moving_crates)
        else
            number_of_crates.times do
                moving_crate = rearranged_crates[from].pop
                rearranged_crates[to].push(moving_crate)
            end
        end
    end

    rearranged_crates
end

def top_crates(crates)
    crates.collect { |_, v| v.last }.join
end

crates = get_crate_stacks(drawing)
moves = get_moves(drawing)

rearranged_crates_part_1 = rearrange(crates, moves)
rearranged_crates_part_2 = rearrange(crates, moves, true)

puts "(Part 1) The top crates on each stack are #{top_crates(rearranged_crates_part_1)}"
puts "(Part 2) The top crates on each stack are #{top_crates(rearranged_crates_part_2)}"
