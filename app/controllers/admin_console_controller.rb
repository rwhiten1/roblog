class AdminConsoleController < ApplicationController
  skip_before_filter :check_authentication, :only => ["login","login_form"]
  skip_before_filter :check_authorization, :only => ["login", "login_form"]
  respond_to :html, :xml
  layout "admin_console"
  load_and_authorize_resource :class => "Article"
  
  
  def index
    if !((current_user.role? :superuser) || (current_user.role? :publisher))
      raise CanCan::AccessDenied.new("You are not authorized to view that page")
    end
    @articles = current_user.articles
    #these two are provided for authorization verification at the view level.
    @role = Role.new
    @article = Article.new
  end
  
  
  #This method will mainly be used to preview unpublished articles.
  def show
    @article = Article.find(params[:id])
    respond_with(@article)
  end
  
  
  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    @user = User.find(current_user.id)
    if !@user.author
      author = @user.build_author
      author.pseudo_last = @user.last_name
      author.pseudo_first = @user.first_name
      author.save
    end
  end
  
  def create
    article = Article.new(params[:article])
    article.publish_it if params[:article][:published] == "1"
    user = User.find(current_user.id)
    user.author.articles << article
    article.save
    @articles = Article.all
    redirect_to :action => "index"
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def save_edits
    @article = Article.find(params[:id])
    @article.synopsis = params[:article][:synopsis]
    @article.body = params[:article][:body]
    update_publish_status(@article,params[:article][:published])
    @article.save
    @article
    redirect_to :action => "edit", :id => @article.id
  end
  
  def update
    @article = Article.find(params[:id])
    #store this copy of the article in the session, in case there needs to be an undo
    @article.body = params[:article][:body]
    @article.synopsis = params[:article][:synopsis]
    update_publish_status(@article,params[:article][:published])
    @article.save
    redirect_to :action => "show"
  end
  
  private
  
  def update_publish_status(article,status)
    if status == "1" then
      article.publish_it
    else
      article.edit_mode
    end
  end
end
