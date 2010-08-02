require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sequencer" do
  it "should run three actions" do
    sq = Sequencer.new([
      Proc.new { |sq|
        puts "xx"
        sq.next
      },
      Proc.new { |sq|
        puts "xx"
        sq.next
      },
      Proc.new { |sq|
        puts "xx"
        sq.next
      }
    ])
    sq.next
  end
end
