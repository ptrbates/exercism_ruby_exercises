module Transpose
  def self.transpose(input)
    output = []
    lines = pad_left_with_spaces(input.lines.map(&:chomp))

    lines.each do |line|
      line.chars.each_index do |index|
        output[index] = output[index] ? output[index] + line[index] : line[index]
      end
    end

    output.join("\n")
  end

  def self.pad_left_with_spaces(lines)
    padded_lines = []
    until lines.empty?
      current_line = lines.shift
      longest_line_after_this = lines.map(&:length).max || 0
      padded_lines.push(current_line.ljust(longest_line_after_this))
    end
    padded_lines
  end
end
