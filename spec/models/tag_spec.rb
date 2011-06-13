require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag, "Relationships" do
  it {should have_and_belong_to_many(:articles)}
end

describe Tag do
  before(:each) do
    @tag1 = Factory.create(:tag, :tag_name => "Tag_1")
    0.upto(4) do |i|
      a = Factory.create(:article, :title => "Tag_1_Article_#{i}")
      a.save
      @tag1.articles << a
      @tag1.increment_article_count
    end
    @tag1.save

    @tag2 = Factory.create(:tag, :tag_name => "Tag_2")
    0.upto(2) do |i|
      a = Factory.create(:article, :title => "Tag_2_Article_#{i}")
      a.save
      @tag2.articles << a
      @tag2.increment_article_count
    end
    @tag2.save

    @tag3 = Factory.create(:tag, :tag_name => "Tag_3")
    0.upto(3) do |i|
      a = Factory.create(:article, :title => "Tag_3_Article_#{i}")
      a.save
      @tag3.articles << a
      @tag3.increment_article_count
    end
    @tag3.save

  end

  it "should use a counter cache for articles" do
   @tag1.articles.size.should == 5
   @tag2.articles.size.should == 3
  end

  it "should return the average tag usage" do
    Tag.average_usage.should == 4
  end

  it "should return the stdev of tag usage" do
    Tag.tag_usage_stddev.should == 1.41
  end

  it "should compute the number of stddev's a tags usage is from the mean" do
    @tag3.deviations.should == 0
    @tag1.deviations.should == 1
    @tag2.deviations.should == -1

  end
end