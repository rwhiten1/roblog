class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  layout "articles"
  #Skip all the filters for right now
  #skip_before_filter :check_authentiction, :only => ["show", "index"]
  #skip_before_filter :check_authorization#, :only => ["show", "index"]
  skip_before_filter :authenticate_user!, :only => ['new', 'create']
  #load_and_authorize_resource 
  #skip_authorize_resource :only => ['new', 'create']
  
  def index
    puts "AM I CALLING COMMENT.INDEX?"
    @comments = Comment.all
    @article = Article.find(params[:article_id])
    #redirect_to :controller => "articles", :action => "show"
    render "articles/show"
    
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    puts "AM I CALLING COMMENT.NEW?"
    if(!user_signed_in?)
      session[:"return_to"] = request.full_path
      redirect_to new_user_session_path
    else
      @comment = Comment.new
      
       respond_to do |format|
         format.html # new.html.erb
         format.xml  { render :xml => @comment }
       end
    end
   
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    if(!user_signed_in?)
      session[:"return_to"] = request.fullpath
      session[:comment_data] = params[:comment][:body]
      redirect_to new_user_session_path
    else
       @article = Article.find(params[:article_id])
       @comment = @article.comments.create(params[:comment])
       @comment.save #not sure if this is necessary
       session[:comment_data] = nil
       redirect_to "/articles/#{@article.id}"
    end
    
   
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    puts ">>>> Destroying a comment <<<<"
    @comment = Comment.find(params[:id])
    puts "found comment>>> #{@comment}"
    @article = @comment.article
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(article_path(@article)) }
      format.xml  { head :ok }
    end
  end
end
