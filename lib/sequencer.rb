class Sequencer

  def initialize(procs=[])
    @procs = procs
  end

  def next
    if @procs.size > 0
      @procs.shift.call(self)
    else
    end
  end

end
