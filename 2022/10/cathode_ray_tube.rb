def run(execution_stack)
    x = 1
    rssi_values = []

    cycle = 1

    until execution_stack.length == 0 do
        instruction, value = execution_stack.last.split

        case instruction
        when "noop"
        then
            cycle += 1
            if is_checkpoint?(cycle)
                puts "x: #{x}, cycle: #{cycle}"
                rssi_values << x * cycle
            end

            execution_stack.pop
        when "addx"
        then
            cycle += 1
            if is_checkpoint?(cycle)
                puts "x: #{x}, cycle: #{cycle}"
                rssi_values << x * cycle
            end

            cycle += 1
            x += value.to_i

            if is_checkpoint?(cycle)
                puts "x: #{x}, cycle: #{cycle}"
                rssi_values << x * cycle
            end

            execution_stack.pop
        end
    end

    rssi_values.sum
end

def is_checkpoint?(cycle)
    cycle == 20 || (cycle - 20) % 40 == 0
end

program = File.readlines("program.txt", chomp: true)
execution_stack = program.reverse

puts "(Part 1) Sum of the signal strengths is #{run(execution_stack)}"
