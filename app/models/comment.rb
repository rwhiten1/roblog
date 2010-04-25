class Comment < ActiveRecord::Base
  belongs_to :article
  validates_presence_of :user_id, :article_id, :body, :on => :create, :message => "can't be blank"
  
end
