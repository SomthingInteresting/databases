class InteractiveCalculator
  def initialize io
    @io = io
  end

  def subtract
    @io.puts "Please enter a number:"
    first_number = @io.gets.to_i
    @io.puts "Please enter another number:"
    second_number = @io.gets.to_i
    @io.puts "Here is your result: #{first_number} - #{second_number} = #{first_number - second_number}"
  end
end