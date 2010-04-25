require "RedCloth"

class Article < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :tags # , :join_table => "articles_tags", :foreign_key => "tag_id"
  
  def add_comment(c)
    #comment = Comment.new
    #comment.body = hash[:text]
    #comment.user_id = hash[:user]
    #puts "Article id: #{self.id}, Comment Body: #{comment.body}"
    #comment.article_id = self.id
    self.comments << c
    self.save
  end
  
  def delete_comment(cid)
    comment = nil
    self.comments.each {|cn| comment = cn if cn.id == cid}
    self.comments.delete(comment)
    self.save
    
  end
  
  #My hope is that after implementing a caching mechanism, this won't really matter.
  #This could be a potential bottleneck since entire blog posts will be passed through this
  #markup tool.  If it doesn't work out, I will save both a textile and html version in the DB.
  def render_to_html
    RedCloth.new(self.body).to_html
  end
  
  def publish_it
    self.published = true
    self.save
  end
  
  def edit_mode
    self.published = false
    self.save
  end
  
  def add_tag(tag)
    self.tags << tag
    self.save
  end
  
  def remove_tag(tag)
    self.tags.delete(tag)
    self.save
  end
  
  def get_status
    if self.published? then
      return "published"
    else
      return "draft"
    end
  end
  
  
  
end
