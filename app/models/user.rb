require 'digest/sha2'
class User < ActiveRecord::Base
  after_initialize :default_roles
  #it might be best to pull this out of the DB somehow?  This seems brittle.
  ROLES = {:superuser => "Superuser", :publisher => "Publisher", :commenter => "Commenter"}
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :last_name, :first_name
  has_many :comments #, :class_name => "comment", :foreign_key => "reference_id"
  has_one :author, :class_name => "Author"
  has_many :articles, :through => :author
  has_and_belongs_to_many :roles #, :join_table => "table_name", :foreign_key => "roles #_id"
  validates_uniqueness_of :username
  validates_presence_of :last_name, :on => :create, :message => "can't be blank"
  validates_presence_of :first_name, :on => :create, :message => "can't be blank"
  #validates_confirmation_of :pass_hash
  
  def role?(the_role)
    if !roles 
      return false
    end
    roles.select{|r| r.name == ROLES[the_role] }.count > 0
  end
  
  
  def add_default_role
    default_roles
  end
  
  #To support OAuth authentication with Facebook
  def self.find_for_facebook_oauth(access_token, signed_in_resource = nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end
  
  #pulls a user's facebook email address from oauth data and uses that for new user registration
  def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
          user.email = data["email"]
        end
      end
    end
  
  private
  
  def default_roles
    
    r = Role.find_by_name("Commenter")
    
    if !r
      r = Role.new
      r.name = "Commenter"
      r.save
    end
    
    roles << r
  end
end
