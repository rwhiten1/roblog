class TagsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => ['index', 'show']
  respond_to :html, :xml, :json

  def create
    @tag = Tag.find_or_create_by_tag_name(params[:tag_name])
    @article = Article.find(params[:article_id])
    @tag.articles << @article
    @tag.increment_article_count
    #respond_with(@tag, :layout => false, :partial => "tag_list")
    render "article_tags"
  end

  def index
    if request.xhr?
       find_params = {
      :conditions => ["tag_name LIKE ?", "%" + params["term"] + "%"],
      :limit => 20
    }
      @tags = Tag.find(:all,find_params)
    else
      @tags = Tag.all
    end
    respond_with(@tags, :layout => false)
  end
end
