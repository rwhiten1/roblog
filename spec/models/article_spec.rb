require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Article, "description" do
  it{should have_many(:comments)}
  it{should have_and_belong_to_many(:tags)}
  it{should belong_to(:author)}
end