def fibonacci(n)
  return n if n <= 1
  fibonacci(n - 1) + fibonacci(n - 2)
end

class Takeuchi
  def self.tarai(x, y, z)
    if y < x
      tarai(
        tarai(x - 1, y, z),
        tarai(y - 1, z, x),
        tarai(z - 1, x, y)
      )
    else
      y
    end
  end
end

class Table
  def generate(value, col, row)
    table = "<table>"

    row.times do |row_i|
      table += "\n  <tr class='row-#{row_i}'>"
      col.times { |col_i| table += "\n    <td>(#{col_i}) #{value}</td>" }
      table += "\n  </tr>"
    end

    table += "\n</table>"
  end
end

### # -*- frozen_string_literal: true -*-
