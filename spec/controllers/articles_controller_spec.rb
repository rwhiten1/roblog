require "spec_helper"

describe ArticlesController do
  describe "GET" do
    before(:each) do
      @email = do_signin
      @tag = Factory.create(:tag)
      @a1 = Factory.create(:article)
      @a2 = Factory.create(:article)
      @a1.save
      @a2.save
      @a1.tags << @tag
      @a2.tags << @tag
      #user = User.find_by_email(@email)
      #user.articles << @a1
      #user.articles << @a2
    end

    after(:each) do
      do_signout(@email)
    end

    it "should return a list of articles for a given tag" do

      get :tagged, :tag_id => @tag.id
      response.code.should == "200"
      response.should be_success
      response.should render_template('index')
      assigns[:articles].should_not == nil
      articles = assigns[:articles]
      articles.size.should == 2
      assigns[:tag].should_not == nil
      assigns[:tag].id.should == @tag.id

    end
  end

end
