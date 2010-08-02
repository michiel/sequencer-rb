require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Collector" do

  it "should do something" do
    f = proc {|st|
      st.collect += 1
      st.proc_finished
    }

    col = Collector.new(
      [f,f,f], 
      proc {|st|
      }
    )
    col.collect = 0
    col.start
    col.collect.should == 3
  end

end
