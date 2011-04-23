module TestHelpers
  #set up user roles and rights
  def set_up_roles
    #super user role
    super_user = roles(:superuser)
    rights.each do |right|
      super_user.rights << right 
    end
    super_user.save
    
    #publisher role
    publisher = roles(:publisher)
    publisher.rights << rights(:publish)
    publisher.rights << rights(:new_article)
    publisher.rights << rights(:edit_article)
    publisher.rights << rights(:save_article_edits)
    publisher.rights << rights(:update_article)
    #publisher.rights << rights(:new_comment)
    #publisher.rights << rights(:publish_comment)
    #publisher.rights << rights(:edit_comment)
    #publisher.rights << rights(:update_comment)
    publisher.save
    
    #commenter role
    commenter = roles(:commenter)
    commenter.rights << rights(:new_comment)
    commenter.rights << rights(:publish_comment)
    commenter.rights << rights(:edit_comment)
    commenter.rights << rights(:update_comment)
    commenter.rights << rights(:destroy_comment)
    commenter.save
    
    #now, assign a role to each test user
    thesuper = users(:admin)
    thepub = users(:publisher)
    thecomment = users(:commenter)
    
    thesuper.roles << super_user
    thepub.roles << publisher
    thepub.roles << commenter
    thecomment.roles << commenter
    thesuper.save
    thepub.save
    thecomment.save
  end
  
  def login_helper(user,pass)
    #this is really only meant for controllers
    user = users(user)
    post :login, {:username => user.username, :password=>pass}
    
  end
end