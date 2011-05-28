require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')



describe Article, "description" do
  it{should have_many(:comments)}
  it{should have_and_belong_to_many(:tags)}
  it{should belong_to(:author)}
end

describe Article, "Markdown and syntax highlighting" do
  before(:each) do
    @article = Factory.create(:article)

    @code = <<-BLOCK
    BLAH BLAH BLAH BLAH
      <code lang="ruby">
        def some_method
          collection.each do |var|
           puts var
          end
        end
      </code>
     BLAH TEXT BLAH
    BLOCK
  end

  it "Saves an md5 checksum for an article" do
    @article.save
    @article.checksum.should_not == nil
  end

  it "if the article changes, so does the checksum" do
    check = @article.checksum
    @article.body = "Some new body"
    @article.save
    @article.checksum.should_not == check
  end

  it "should transform code blocks into xhtml" do
    exp = @article.process_body(@code)
    exp.should match(/<pre class="blackboard"/)
  end

  it "should allow the value for lang to be enclosed in double quotes" do
    q_code = @code.gsub("\"","'")
    exp = @article.process_body(q_code)
    exp.should match(/<pre class="blackboard"/)
  end
end