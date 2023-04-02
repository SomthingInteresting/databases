class StringRepeater
  def initialize(io)
    @io = io
  end

  def repeat
    @io.puts "Hello. I will repeat a string many times."
    @io.puts "Please enter a string"
    string = @io.gets
    @io.puts "Please enter a number of repeats"
    number_of_repeats = @io.gets.to_i
    @io.puts "Here is your result:"
    @io.puts string * number_of_repeats
  end
end
