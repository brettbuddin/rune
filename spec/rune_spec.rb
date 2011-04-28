require 'spec_helper'

describe Rune do
  it "should generate a signature from instantiated Rune" do
    rune = Rune.new(
      'http://localhost/people',
      'test',
      {:person => {:name  => "Name", :age => "29"}, :other => "dude"}
    )
    rune.generate.should == 'qiPvkhsTdXJ/2Ee12UrSSfmIRYI='
  end

  it "should generate the same signature for hashes with symbols and string keys" do
    rune_with_symbols = Rune.new(
      'http://localhost/people',
      'test',
      {:person => {:name  => "Name", :age => "29", :crazy => {:nested => "stuff"}}}
    )
    rune_with_strings = Rune.new(
      'http://localhost/people',
      'test',
      {'person' => {'name'  => "Name", 'age' => "29", 'crazy' => {'nested' => "stuff"}}}
    )

    rune_with_symbols.generate.should == rune_with_symbols.generate
  end

  it "should generate the same signature for two orderings of parameters" do
    rune = Rune.new(
      'http://localhost/people',
      'test',
      {:other => "dude", :person => {:age => "29", :name  => "Name"}}
    )
    rune2 = Rune.new(
      'http://localhost/people',
      'test',
      {"person" => {:name  => "Name", :age => "29"}, :other => "dude"}
    )

    rune.generate.should == rune2.generate
  end
end
