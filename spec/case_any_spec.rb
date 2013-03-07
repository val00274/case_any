require 'rspec'
require 'case_any'

describe Kernel::AnyClass do
  it "anyは常にmatchする." do
    f = lambda {|arg|
      case arg
      when any
        :match
      else
        :no_match
      end
    }

    f.call(1).should == :match
    f.call(2).should == :match
    f.call(3).should == :match
    f.call("foo").should == :match
    f.call("bar").should == :match
    f.call(nil).should == :match
  end

  it "anyは配列の部分マッチに使用出来る." do
    f = lambda {|arg|
      case arg
      when [:x, any]
        :x_
      when [any, 0]
        :_0
      when [:a, 1]
        :a1
      when [:a, 2]
        :a2
      when [:b, 1]
        :b1
      when [:b, 2]
        :b2
      else
        :no_match
      end
    }

    f.call([:a, 0]).should == :_0
    f.call([:a, 1]).should == :a1
    f.call([:a, 2]).should == :a2
    f.call([:a, 3]).should == :no_match

    f.call([:b, 0]).should == :_0
    f.call([:b, 1]).should == :b1
    f.call([:b, 2]).should == :b2
    f.call([:b, 3]).should == :no_match

    f.call([:x, 0]).should == :x_
    f.call([:x, 1]).should == :x_
    f.call([:x, 2]).should == :x_
    f.call([:x, 3]).should == :x_
  end
end

