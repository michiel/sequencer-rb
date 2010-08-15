require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sequencer" do
  it "should run three actions" do

    acc = 0
    f = lambda { |cb|
      acc+=1
      cb.call
    }
    Sequencer.new([f,f,f]).start

    acc.should == 3

  end

  it "should add two actions" do

    acc = 0
    f = lambda { |cb|
      acc+=1
      cb.call
    }

    seq = Sequencer.new
    seq.add(f)
    seq.add(f)
    seq.start

    acc.should == 2

  end

  it "should reverse the sequence" do

    acc = 0

    seq = Sequencer.new([
      lambda { |cb|
        acc = 1
        cb.call
      },
      lambda { |cb|
        acc = 2
        cb.call
      }
    ])
    seq.reverse!
    seq.start

    acc.should == 1

  end

  it "should work with nested lexical scope" do

    acc = 0
    f = lambda { |cb|
      callback = lambda {
        acc+=1
        cb.call
      }
      callback.call
    }

    Sequencer.new([f,f,f]).start

    acc.should == 3

  end

  it "should work with threads" do

    acc = 0
    f = lambda { |cb|
      Thread.new do
        acc+=1
        cb.call
      end
    }

    Sequencer.new([f,f,f]).start

    acc.should == 3

  end

  it "should fail threads with sleep because rspec doesn't do async" do

    acc = 0
    f = lambda { |cb|
      Thread.new do
        sleep 5
        acc+=1
        cb.call
      end
    }

    Sequencer.new([f,f,f]).start

    acc.should == 0

  end

  it "should allow nested usage" do

    acc = 0

    f = lambda { |cb|
        acc+=1
        cb.call
    }

    Sequencer.new([ f, f, f,
                  Sequencer.new([f,f]).start_callback
    ]).start

    acc.should == 5

  end

  it "should have a working state accessor" do

    acc = 0

    f = lambda { |cb|
      acc+=1
      cb.call
    }

    seq = Sequencer.new([ f, f, f ])

    seq.start
    seq.running.should == false

  end

end
