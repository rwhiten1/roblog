class UserController < ApplicationController
  
  #skip all the filters for now, for development purposes
  skip_before_filter :check_authentication, :only => ["new", "create"]
  skip_before_filter :check_authorization#, :only => ["new", "create"]
  load_and_authorize_resource
  layout "admin_console"
  
  def new
    @user = User.new
    @article = Article.find(params[:id]) if params[:id]
    render :action => "create"
  end
  
  def create
    @user = User.new()
    @user.username = params[:user][:username]
    @user.email = params[:user][:email]
    #need to make sure we store the password
    @user.password = params[:user][:pass_hash]
    @user.save
    #I would like them to be back on the page they came from after this
    #first, put them into the session
    session[:user] = @user.id
    #now, redirect to back
    redirect_to "/articles/#{params[:article_id]}"
  end

  def update
    @user = User.find(params[:id])
    @user.roles.clear #clear out all the roles
    params[:user][:roles].each do |role,val|
     #the only ones that should be here are the checked ones
      unless val.to_i == -1
        @user.roles << Role.find(val.to_i)
      end
    end
    @users = User.all
    render "index"
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end

end
