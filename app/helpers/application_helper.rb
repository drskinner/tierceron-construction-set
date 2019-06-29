module ApplicationHelper
  def self.word_wrap(text, line_width = 78)
    return '' if text.blank?

    text.split("\n").collect do |line|
      line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end
end
