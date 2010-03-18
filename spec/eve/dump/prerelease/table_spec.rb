require 'spec_helper'

describe Eve::Dump::Prerelease::Table do
  subject { Eve::Dump::Prerelease::Table.new(mock_sql('agtAgentTypes')) }

  it "should load the table name" do
    subject.name.should == "agtAgentTypes"
  end

  it "should load the field names" do
    subject.fields.should have(2).items
    subject.fields.should include("agentTypeID")
    subject.fields.should include("agentType")
  end
end
