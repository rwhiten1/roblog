class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    puts "User: #{user.email} User Roles:"
    user.roles.each do |role|
      puts role.name
    end
    if user.role? :superuser
      puts "I am a super user!!"
      can :manage, :all
    elsif user.role? :publisher
      can :read, :all
      
      can :create, Article
      can :update, Article do |article|
        aut = article.try(:author)
        aut.try(:user_id) == user.id
      end
      
      ##publishers can modify comments as well
      #can :create, Comment
      #can :update, Comment do |comment|
      #  comment.try(:user) == user
      #end
      
    elsif user.role? :commenter
      can :read, :all
      can :create, Comment
      can :update, Comment do |comment|
        comment.try(:user) == user
      end
    else
      can :read, :all
    end
  end


end