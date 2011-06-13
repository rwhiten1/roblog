class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    
    if user.role? :superuser
      can :manage, :all
    elsif user.role? :publisher
      can [:read, :create], [Article, Comment, Tag]
      can :tagged, [Article, Tag]
      can :untag, [Article, Tag]
      
      #can :create, Article
      can [:update, :destroy], Article do |article|
        aut = article.try(:author)
        aut.try(:user_id) == user.id
      end
      
      ##publishers can modify comments as well
      #can :create, Comment
      #can :update, Comment do |comment|
      #  comment.try(:user) == user
      #end
      
    elsif user.role? :commenter
      can :read, [Article, Comment, Tag]
      can :tagged, [Article, Tag]
      can :create, Comment
      can [:update, :destroy], Comment do |comment|
        comment.try(:user) == user
      end
    else
      can :read, :all
    end
  end


end