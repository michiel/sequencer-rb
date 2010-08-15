# A class for running arbitrary actions in sequence.
class Sequencer

  attr_reader :running

  def initialize(lambdas=[])
    @lambdas = lambdas
    @running = false
  end

  # Add a function to the sequence
  def add(f)
    @lambdas.push(f)
  end

  # Reverse the order of the sequence
  def reverse!
    @lambdas.reverse!
  end

  # Start running
  def start
    @running = true
    self.next
  end

  # Return a lambda to trigger the start
  def start_callback
    lambda {
      self.start
    }
  end

  # Run the next function (if any)
  def next
    if @lambdas.size > 0
      @lambdas.shift.call(lambda { self.next })
    else
      @running = false
    end
  end

end
