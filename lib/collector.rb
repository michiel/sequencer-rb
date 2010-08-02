class Collector

  attr_accessor :collect

  def initialize(procs, fin)
    @procs    = procs
    @finalize = fin
    @counter  = 0
    @collect  = nil
  end

  def add(f)
    @procs.push(f)
  end

  def start
    @procs.each do |f|
      f.call(self)
    end
  end

  def proc_finished
    @counter += 1
    if @procs.size == @counter
      @finalize.call(self)
    end
  end

end
