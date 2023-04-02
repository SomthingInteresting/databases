require 'interactive_calculator'

RSpec.describe InteractiveCalculator do
  it "subtracts two numbers" do
    io = double :io
    expect(io).to receive(:puts).with("Please enter a number:")
    expect(io).to receive(:gets).and_return("5")
    expect(io).to receive(:puts).with("Please enter another number:")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Here is your result: 5 - 3 = 2")

    calculator = InteractiveCalculator.new(io)
    calculator.subtract
  end
end