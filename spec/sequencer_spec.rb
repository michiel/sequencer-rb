require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sequencer" do
  it "should run three actions" do

    acc = 0
    f = proc { |sq|
      acc+=1
      sq.next
    }
    Sequencer.new([f,f,f]).start

    acc.should == 3

  end

  it "should run two actions" do

    acc = 0
    f = proc { |sq|
      acc+=1
      sq.next
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
      proc { |sq|
        acc = 1
        sq.next
      },
      proc { |sq|
        acc = 2
        sq.next
      }
    ])
    seq.reverse!
    seq.start

    acc.should == 1

  end

end
