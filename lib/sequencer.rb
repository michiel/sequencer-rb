class Sequencer

  def initialize(procs=[])
    @procs = procs
  end

  def add(f)
    @procs.push(f)
  end

  def reverse!
    @procs.reverse!
  end

  def start
    self.next
  end

  def next
    if @procs.size > 0
      @procs.shift.call(self)
    else
    end
  end

end
