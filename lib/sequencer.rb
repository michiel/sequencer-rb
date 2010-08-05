# A class for running arbitrary actions in sequence.
class Sequencer

  def initialize(procs=[])
    @procs = procs
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
    self.next
  end

  # Run the next function (if any)
  def next
    if @procs.size > 0
      @procs.shift.call(proc { self.next })
    end
  end

end
