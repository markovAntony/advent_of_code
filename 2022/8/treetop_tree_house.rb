file = File.readlines("grid.txt", chomp: true)
file.map(&:split)

grid = file.map(&:chars).map { |e| e.map(&:to_i) }

def visible_trees_edge(grid)
    (grid.length*2) + (grid[0].length*2) - 4
end

def visible_trees_interior(grid)
    visible_trees = 0

    cols = grid.transpose
    rows = grid

    col_range = [*1..cols.length-2]
    row_range = [*1..rows.length-2]

    col_range.each do |col_idx|
        tree = -1
        row_range.each do |row_idx|
            tree = grid[col_idx][row_idx]

            up = cols[row_idx].slice(0, col_idx).all? { |t| tree > t }
            down = cols[row_idx].slice(col_idx+1, cols.length).all? { |t| tree > t }
            left = rows[col_idx].slice(0, row_idx).all? { |t| tree > t }
            right = rows[col_idx].slice(row_idx+1, rows.length).all? { |t| tree > t }

            visible_trees += [up, down, left, right].any? ? 1 : 0
        end
    end

    visible_trees
end

def scenic_score(trees, tree)
    view = []
    trees.each do |t|
        view << t
        break if t >= tree
    end

    view.count
end

def highest_scenic_score(grid)
    cur_highest_scenic_score = 0

    cols = grid.transpose
    rows = grid

    col_range = [*1..cols.length-2]
    row_range = [*1..rows.length-2]

    col_range.each do |col_idx|
        row_range.each do |row_idx|
            scenic_score = 0

            tree = grid[col_idx][row_idx]

            up = scenic_score(cols[row_idx].slice(0, col_idx).reverse, tree)
            down = scenic_score(cols[row_idx].slice(col_idx+1, cols.length), tree)
            left = scenic_score(rows[col_idx].slice(0, row_idx).reverse, tree)
            right = scenic_score(rows[col_idx].slice(row_idx+1, rows.length), tree)

            scenic_score = up * down * left * right

            if scenic_score > cur_highest_scenic_score
                cur_highest_scenic_score = scenic_score
            end
        end
    end

    cur_highest_scenic_score    
end

def visible_trees(grid)
    visible_trees_edge(grid) + visible_trees_interior(grid)
end

puts "(Part 1) Total trees visible outside grid: #{visible_trees(grid)}"
puts "(Part 2) Highest scenic score: #{highest_scenic_score(grid)}"

