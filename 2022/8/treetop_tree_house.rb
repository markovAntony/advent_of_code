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

def visible_trees(grid)
    visible_trees_edge(grid) + visible_trees_interior(grid)
end

puts "(Part 1) Total trees visible outside grid: #{visible_trees(grid)}"

