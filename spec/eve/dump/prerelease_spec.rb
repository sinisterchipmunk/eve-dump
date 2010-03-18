require 'spec_helper'

describe Eve::Dump::Prerelease do
  subject { Eve::Dump::Prerelease.new(mock_sql('agtAgentTypes')) }

  it "finds all of the tables in the sql file" do
    subject.table_count.should == 1 #69
  end

  it "defines fields for each table" do
    subject.tables.collect { |t| t.fields.length.should_not == 0 }
  end

  it "constructs a list of insertions" do
    subject.insertions.each do |table, insertions|
      insertions.should_not be_empty
    end
  end

  it "constructs a map of fields to insertion values" do
    subject.insertions.each do |table, insertions|
      insertions.each do |insertion|
        insertion.keys.should_not be_empty
        insertion.values.should_not be_empty
      end
    end
  end

  it "produces a set of Rails model creations" do
    puts subject.to_rails_insertions
  end
end
