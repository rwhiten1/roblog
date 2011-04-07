require 'digest/sha2'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  has_many :comments #, :class_name => "comment", :foreign_key => "reference_id"
  has_and_belongs_to_many :roles #, :join_table => "table_name", :foreign_key => "roles #_id"
  validates_uniqueness_of :username
  #validates_confirmation_of :pass_hash
  
  #def password=(pass)
  #  salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
  #  self.password_salt, self.pass_hash = salt, Digest::SHA256.hexdigest(pass + salt)
  #  self.save
  #end
  #
  #def self.authenticate(username, password)
  #  user = User.find(:first, :conditions=>['username = ?', username])
  #  if user.blank? || Digest::SHA256.hexdigest(password + user.password_salt) != user.pass_hash
  #    raise "Username or password invalid"
  #  end
  #  user
  #end
  #
  #def self.encrypted_password(pass,salt)
  #  Digest::SHA256.hexdigest(pass + salt)
  #end
end
