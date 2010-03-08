require 'digest/sha2'
class User < ActiveRecord::Base
  has_many :comments #, :class_name => "comment", :foreign_key => "reference_id"
  validates_uniqueness_of :username
  
  def password=(pass)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.pass_hash = salt, Digest::SHA256.hexdigest(pass + salt)
    self.save
  end
  
  def self.authenticate(username, password)
    user = User.find(:first, :conditions=>['username = ?', username])
    if user.blank? || Digest::SHA256.hexdigest(password + user.password_salt) != user.pass_hash
      raise "Username or password invalid"
    end
    user
  end
end
