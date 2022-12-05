@shape_scores = {
    "rock" => 1,
    "paper" => 2,
    "scissor" => 3
}

@shape_letters = {
    "A" => "rock",
    "B" => "paper",
    "C" => "scissor"
}

@strategies = {
    "X" => "lose",
    "Y" => "draw",
    "Z" => "win"
}

guide = File.readlines("guide.txt")
guide.map!(&:split)

def winner?(a, b)
    case
    when a == "rock" && b == "paper"
    then true
    when a == "rock" && b == "scissor"
    then false
    when a == "paper" && b == "rock"
    then false
    when a == "paper" && b == "scissor"
    then true
    when a == "scissor" && b == "rock"
    then true
    when a == "scissor" && b == "paper"
    then false
    end
end

def find_score(opponent_shape, strategy)
    possible_shapes = @shape_letters.values.filter { |sl| sl != opponent_shape }

    winning_shape = possible_shapes.detect { |ps| winner?(opponent_shape, ps) }
    losing_shape = possible_shapes.detect { |ps| !winner?(opponent_shape, ps) }

    game_score = case strategy
    when "win" then 6
    when "draw" then 3
    when "lose" then 0
    end

    my_shape = case strategy
    when "win" then winning_shape
    when "draw" then opponent_shape
    when "lose" then losing_shape
    end

    game_score + @shape_scores[my_shape]
end

total_score = 0
guide.each do |g|
    opponent_shape = @shape_letters[g[0]]

    strategy = @strategies[g[1]]

    total_score += find_score(opponent_shape, strategy)
end

puts "Total score is #{total_score}"

