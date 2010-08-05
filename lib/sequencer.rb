# A class for running arbitrary actions in sequence.
class Sequencer

  attr_reader :running

  def initialize(procs=[])
    @procs   = procs
    @running = false
  end

  # Add a function to the sequence
  def add(f)
    @procs.push(f)
  end

  # Reverse the order of the sequence
  def reverse!
    @procs.reverse!
  end

  # Start running
  def start
    @running = true
    self.next
  end

  # Return a proc to trigger the start
  def start_callback
    proc {
      self.start
    }
  end

  # Run the next function (if any)
  def next
    if @procs.size > 0
      @procs.shift.call(proc { self.next })
    else
      @running = false
    end
  end

end
