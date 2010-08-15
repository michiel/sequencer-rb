class Collector

  attr_accessor :collect

  def initialize(lambdas, fin)
    @lambdas  = lambdas
    @finalize = fin
    @counter  = 0
    @collect  = nil
  end

  def add(f)
    @lambdas.push(f)
  end

  def start
    @lambdas.each do |f|
      f.call(self)
    end
  end

  def lambda_finished
    @counter += 1
    if @lambdas.size == @counter
      @finalize.call(self)
    end
  end

end
