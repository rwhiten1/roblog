##The following factories set up all the rights
#Factory.define :publish, :class => "right" do |r|
#  r.name "Publish"
#  r.controller "admin_console"
#  r.action "create"
#end
#
#Factory.define :new_article, :class => "right" do |r|
#  r.name "New Article"
#  r.controller "admin_console"
#  r.action "new"
#end
#
#Factory.define :edit_article, :class => "right" do |r|
#  r.name "Edit Article"
#  r.controller "admin_console"
#  r.action "edit"
#end
#
#Factory.define :save_article_edits, :class => "right" do |r|
#  r.name "Save Article Edits"
#  r.controller "admin_console"
#  r.action "save_edits"
#end
#
#Factory.define :update_article, :class => "right" do |r|
#  r.name "Update Article"
#  r.controller "admin_console"
#  r.action "update"
#end
#
#Factory.define :admin_console, :class => "right" do |r|
#  r.name "Admin Console"
#  r.controller "admin_console"
#  r.action "index"
#end
#
#Factory.define :admin_logout, :class => "right" do |r|
#  r.name "Admin Logout"
#  r.controller "admin_console"
#  r.action "logout"
#end
#
#Factory.define :new_comment, :class => "right" do |r|
#  r.name "New Comment"
#  r.controller "comments"
#  r.action "new"
#end
#
#Factory.define :publish_comment, :class => "right" do |r|
#  r.name "Publish Comment"
#  r.controller "comments"
#  r.action "create"
#end
#
#Factory.define :edit_comment, :class => "right" do |r|
#  r.name "Edit Comment"
#  r.controller "comments"
#  r.action "edit"
#end
#
#Factory.define :update_comment, :class => "right" do |r|
#  r.name "Update Comment"
#  r.controller "comments"
#  r.action "update"
#end
#
#Factory.define :destroy_comment, :class => "right" do |r|
#  r.name "Destroy Comment"
#  r.controller "comments"
#  r.action "destroy"
#end
#
#Factory.define :show_users, :class => "right" do |r|
#  r.name "Show Users"
#  r.controller "users"
#  r.action "show"
#end
#
#Factory.define :update_user, :class => "right" do |r|
#  r.name "Update User"
#  r.controller "users"
#  r.action "update"
#end
#
#Factory.define :edit_user, :class => "right" do |r|
#  r.name "Edit User"
#  r.controller "users"
#  r.action "edit"
#end

require "#{Rails.root}/app/models/right"

##The following factories define the 3 roles
#Factory.define :comment, :class => "role" do |role|
#  role.name "Commenter"
#  role.rights << Right.new({:name => "New Comment", :controller => "comments", :action => "new"})
#  role.rights << Right.new({:name => "Publish", :controller => "comments", :action => "create"})
#  role.rights << Right.new({:name => "Edit Comment", :controller => "comments", :action => "edit"})
#  role.rights << Right.new({:name => "Update Comment", :controller => "comments", :action => "update"})
#  role.rights << Right.new({:name => "Destroy Comment", :controller => "comments", :action => "destroy"})
#  role.rights << Right.new({:name => "Update User", :controller => "users", :action => "update"})
#  role.rights << Right.new({:name => "Edit User", :controller => "users", :action => "edit"})
#end
#
#Factory.define :publish, :class => "role" do |role|
#  role.name "Publisher"
#  role.rights << Right.new({:name => "New Article", :controller => "admin_console", :action => "new"})
#  role.rights << Right.new({:name => "Publish", :controller => "admin_console", :action => "create"})
#  role.rights << Right.new({:name => "Edit Article", :controller => "admin_console", :action => "edit"})
#  role.rights << Right.new({:name => "Save Article Edits", :controller => "admin_console", :action => "save_edits"})
#  role.rights << Right.new({:name => "Update Article", :controller => "admin_console", :action => "update"})
#end
#
#Factory.define :admin, :class => "role" do |role|
#  role.name "Superuser"
#  role.rights << Right.new({:name => "Admin Console", :controller => "admin_console", :action => "index"})
#  role.rights << Right.new({:name => "Admin Logout", :controller => "admin_console", :action => "index"})
#  role.rights << Right.new({:name => "Show Users", :controller => "users", :action => "show"})
#end
#

Factory.sequence :role_name do |n|
  "Role_#{n}"
end

Factory.define :right do |r|
  r.sequence(:name) { |n| "Right No. #{n}"}
  r.controller {"comments"}
  r.action {"create"}
end

Factory.define :role do |r|
  r.name {Factory.next :role_name}
end

#Factory.define(:right_with_role, :parent => :role) do |right|
#  right.association(:role)
#end

Factory.define(:role_with_rights, :parent => :role) do |role|
  role.after_create do |obj|
    obj.rights = [Factory.create(:right)]
  end
end



Factory.define :user do |u|
  u.sequence(:username) { |n| "foo#{n}"}
  u.sequence(:email) { |n| "foo#{n}@roblog.com"}
  #u.after_build do |obj|
  #  obj.password= "secret"
  #  #obj.password_confirmation = "secret"
  #  #u.password_confirmation { |f| f.password }
  #end
  u.password {"password"}
end

Factory.define :article do |a|
  a.sequence(:title) { |n| "Article #{n}"}
  a.synopsis {"This is a test article"}
  a.body {"This is the body of the article"}
  a.published {false}
end




