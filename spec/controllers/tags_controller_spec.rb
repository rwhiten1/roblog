require 'spec_helper'

describe TagsController do
  describe "Routes" do
    it "should create a route for new tags" do
      {:get => '/tags/new'}.should route_to(:controller => 'tags', :action => "new")

    end

    it "should get a list of tags for a particular article" do
      {:get => '/articles/1/tags'}.should route_to(:controller => 'tags', :action => 'index', :article_id => "1")
    end

    it "should post a tag to an article" do
      {:post => '/articles/1/tags'}.should route_to(:controller => 'tags', :action => 'create', :article_id => "1")
    end

    it "should get a list of all the articles for a tag" do
      {:get => '/tags/1/articles/tagged'}.should route_to(:controller => 'articles', :action => 'tagged', :tag_id => "1")
    end
  end

  describe "POST" do
    before(:each) do
      @article = Factory.create(:article)
      @article.save
      @tag = Factory.create(:tag)
      @tag.save
      
      @email = do_signin
    end

    after(:each) do
      do_signout(@email)
    end

    it "should associate an existing tag with an article" do
      xhr :post, :create, :article_id => @article.id, :tag_name => @tag.tag_name

      response.should be_success
      response.should render_template("tags/article_tags")
      #response.should render_template("tag_list")

      @article.tags[0].id.should == @tag.id

    end

    it "should create a new tag on the fly and associate it with an article" do
      xhr :post, :create, :article_id => @article.id, :tag_name => "BrandNew"
      response.should be_success
      response.should render_template("tags/article_tags")
      #$response.should render_template("tag_list")
      tag = Tag.find_by_tag_name("BrandNew")
      tag.should_not == nil
      @article.tags[0].id.should == tag.id
      assigns[:tag].id.should == tag.id
    end
  end

  describe "GET" do
    before(:each) do
     @article = Factory.create(:article)
      @article.save
      @tag = Factory.create(:tag)
      @tag.save

      @email = do_signin
    end

    after(:each) do
      do_signout(@email)
    end

    it "should return a filtered list of tags when invoked with xhr" do
      t1 = Factory.create(:tag, :tag_name => "searchtag")
      t1.save
      t2 = Factory.create(:tag,:tag_name => "searchthis")
      t2.save
      ex_tags = [t1,t2]

      xhr :get, :index, :term => "search", :format => :json
      response.should be_success
      #response.should render_template("tag_list")
      response.body.should == ex_tags.to_json
      tags = assigns[:tags]
      tags.should_not == nil
      tags.size.should == 2
      tags[0].tag_name.should == "searchtag"
      tags[1].tag_name.should == "searchthis"

    end


  end
end
