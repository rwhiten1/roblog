class ArticlesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => ["index", "show"]
  #skip_before_filter :check_authorization#, :only => ["index", "show"]
  load_and_authorize_resource
  respond_to :html, :xml
  layout "articles"
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml  { render :xml => @article }
    #end
    
    respond_with(@article)
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    if(user_signed_in?)
      @article = Article.new
      @user = User.find(current_user.id)
      
      if !@user.author
        @author = @user.build_author
        @author.pseudo_last = @user.last_name
        @author.pseudo_first = @user.first_name
        @author.save
      end
      
      #add the article to the user
      respond_with(@article)
    end

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.xml  { render :xml => @article }
    #end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    if user_signed_in?
      @article = Article.new(params[:article])
      @user = User.find(current_user.id)
      @user.author.articles << @article
      respond_with(@article)
    end

    #respond_to do |format|
    #  if @article.save
    #    format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
    #    format.xml  { render :xml => @article, :status => :created, :location => @article }
    #  else
    #    format.html { render :action => "new" }
    #    format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
    #  end
    #end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
end
