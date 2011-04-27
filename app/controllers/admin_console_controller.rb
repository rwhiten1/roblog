class AdminConsoleController < ApplicationController
  skip_before_filter :check_authentication, :only => ["login","login_form"]
  skip_before_filter :check_authorization, :only => ["login", "login_form"]
  respond_to :html, :xml
  layout "admin_console"
  
  def login_form
    @article = Article.find(params[:id]) if params[:id]
    render
  end
  
  def index
    @articles = Article.all
    #these two are provided for authorization verification at the view level.
    @role = Role.new
    @article = Article.new
  end
  
  def login
    #puts "logging in user....."
    
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user] = user.id
        #puts "The intended controller is: #{session[:intended_controller]}, The intended action: #{session[:intended_action]}"
        
        if user.roles.detect{|r| r.name == "Commenter"}
          if params[:article_id]
          #if the user is a commenter and there is an article_id present
             @article = Article.find(params[:article_id])
             redirect_to(article_path(@article))
          else
             redirect_to :action => "index", :controller => "articles"
          end
            
        elsif session[:intended_url]
          redirect_to session[:intended_url] #:action => session[:intended_action], :controller => session[:intended_controller]
        else
          #this is where I need to render an admin index.
          @articles = Article.all
          redirect_to :action=>"index", :controller => "articles"
        end
      else
        flash.now[:notice] = "Invalid user/password combination"
        redirect_to :action => "index", :controller => "articles"
      end
      
    end
  end
  
  def logout
    session[:user] = nil
    redirect_to :controller => "articles", :action => "index"
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
