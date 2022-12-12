class Node
    attr_accessor :next, :value

    def initialize(value)
        @value = value
    end
end

def touching?(head, tail)
  (head[:x] - tail[:x]).abs <= 1 && (head[:y] - tail[:y]).abs <= 1
end

def move_tail(head, tail)
    delta_x = head[:x] - tail[:x]
    delta_y = head[:y] - tail[:y]

    if delta_x.abs >= 2
        tail[:x] += delta_x / delta_x.abs

        if delta_y.abs > 0
          tail[:y] += delta_y / delta_y.abs
        end
    else
        tail[:y] += delta_y / delta_y.abs

        if delta_x.abs > 0
          tail[:x] += delta_x / delta_x.abs
        end
    end

    tail
end

def create_rope(knots)
    rope = Array.new(knots) { Node.new({ x: 0, y: 0 }) }

    next_knot = nil
    rope.reverse.each do |knot|
      knot.next = next_knot
      next_knot = knot
    end

    rope
end

def move_knots(rope, visits)
    rope.each do |knot|
        if knot.next.nil?
          visits << [knot.value[:x], knot.value[:y]]
        else
          head = knot.value
          tail = knot.next.value

          knot.next.value = move_tail(head, tail) unless touching?(head, tail)
        end
    end
end

def simulate(moves, knots)
    rope = create_rope(knots)
    visits = []

    moves.each do |move|
        direction, steps = move.split

        steps.to_i.times do
            case direction
            when 'L'
                rope[0].value[:x] -= 1
            when 'U'
                rope[0].value[:y] += 1
            when 'R'
                rope[0].value[:x] += 1
            when 'D'
                rope[0].value[:y] -= 1
            end

            move_knots(rope, visits)
        end
    end

    visits.uniq.length
end

moves = File.readlines('moves.txt', chomp: true)

puts "(Part 1) The rope tail visits #{simulate(moves, 2)} positions at least once"
puts "(Part 2) The rope tail visits #{simulate(moves, 10)} positions at least once"