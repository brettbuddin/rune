require 'spec_helper'

describe Rune do
  it "should generate a signature from instantiated Rune" do
    rune = Rune.new(
      'http://localhost/people',
      'test',
      {:person => {:name  => "Name", :age => "29"}, :other => "dude"}
    )
    rune.generate.should == 'iPMlDY50Z5SYdj6+ISUUtSYxbZQ='
  end

  it "should generate the same signature for hashes with symbols and string keys" do
    rune_with_symbols = Rune.new(
      'http://localhost/people',
      'test',
      {:person => {:name  => "Name", :age => "29"}}
    )
    rune_with_strings = Rune.new(
      'http://localhost/people',
      'test',
      {'person' => {'name'  => "Name", 'age' => "29"}}
    )

    rune_with_symbols.generate.should == rune_with_symbols.generate
  end
end
