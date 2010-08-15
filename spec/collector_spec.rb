require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Collector" do

  it "should do something" do
    f = lambda {|st|
      st.collect += 1
      st.lambda_finished
    }

    col = Collector.new(
      [f,f,f], 
      lambda {|st|
      }
    )
    col.collect = 0
    col.start
    col.collect.should == 3
  end

end
