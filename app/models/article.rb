#require "RedCloth"
#require "digest/sha2"
require "digest/md5"
require "uv"

class Article < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :tags # , :join_table => "articles_tags", :foreign_key => "tag_id"
  belongs_to :author, :class_name => "Author", :foreign_key => "author_id"

  #callbacks
  before_save :check_body

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
    #RedCloth.new(self.body).to_html
    if self.body_html?
      self.body_html
    else
      check_body
      self.save
      self.body_html
    end
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

  def process_body(text, options = {})
      text_pieces = text.split(/(<code>|<code lang="[A-Za-z0-9_-]+">|
        <code lang='[A-Za-z0-9_-]+'>|<\/code>)/)
      #text_pieces.each_with_index{|p,i| puts "[#{i}]>> #{p}"}
      in_pre = false
      language = nil
      text_pieces.collect do |piece|
        if piece =~ /^<code( lang=(["'])?(.*)\2)?>$/
          language = $3
          in_pre = true
          nil
        elsif piece == "</code>"
          in_pre = false
          language = nil
          nil
        elsif in_pre
          #puts "IN PRE: text piece = #{piece}"
          lang = language ? language : "ruby"
          #code(piece.strip, :lang => lang)
          Uv.parse( piece, "xhtml", lang, true, "blackboard")
        else
          markdown(piece, options)
        end
      end.join("")
    end

    def markdown(text, options = {})
      if options[:split]
        RDiscount.new(strip_tags(text.strip)).to_html
      else
        RDiscount.new(text.strip).to_html
      end
    end


  private

  def check_body
    #digest = Digest::SHA2.new do |d|
    #   d << self.body
    #end
    digest = Digest::MD5.hexdigest(self.body)

    if self.checksum != digest
      self.checksum = digest
      self.body_html = process_body(self.body)
    end

  end



end
