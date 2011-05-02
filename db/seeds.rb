# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#publish = Right.create({:name => "Publish", :controller => "admin_console", :action => "create"})
#new_article = Right.create({:name => "New Article", :controller => "admin_console", :action => "new"})
#edit_article = Right.create({:name => "Edit Article", :controller => "admin_console", :action => "edit"})
#save_article_edits = Right.create({:name => "Save Article Edits", :controller => "admin_console", :action => "save_edits"})
#show_unpub_article = Right.create({:name => "Show Unpubed Article", :controller => "admin_console", :action => "show"})
#update_article = Right.create({:name => "Update Article", :controller => "admin_console", :action => "update"})
#admin = Right.create({:name => "Admin Console", :controller => "admin_console", :action => "index"})
#admin_logout = Right.create({:name => "Admin Logout", :controller => "admin_console", :action => "logout"})
#new_comment = Right.create({:name => "New Comment", :controller => "comments", :action => "new"})
#publish_comment = Right.create({:name => "Publish Comment", :controller => "comments", :action => "create"})
#edit_comment = Right.create({:name => "Edit Comment", :controller => "comments", :action => "edit"})
#update_comment = Right.create({:name => "Update Comment", :controller => "comments", :action => "update"})
#destroy_comment = Right.create({:name => "Destroy Comment", :controller => "comments", :action => "destroy"})
#update_user = Right.create({:name => "Update User"        ,:controller => "users"         ,:action => "update"     })
#edit_user = Right.create({:name => "Edit User"          ,:controller => "users"         ,:action => "edit"       })
#show_users = Right.create({:name => "Show Users"         ,:controller => "users"         ,:action => "show"       })
#users_index = Right.create({:name => "Users Index"        ,:controller => "users"         ,:action => "index"      })
#
#publish.save
#new_article.save
#edit_article.save
#save_article_edits.save
#update_article.save
#admin.save
#new_comment.save
#publish_comment.save
#edit_comment.save
#update_comment.save
#destroy_comment.save
#edit_user.save
#show_users.save
#users_index.save
#
create the roles
publisher_role = Role.create({:name => "Publisher"})
commenter_role = Role.create({:name => "Commenter"})
admin_role = Role.create({:name => "Superuser"})

#publisher_role.rights << publish
#publisher_role.rights << new_article
#publisher_role.rights << edit_article
#publisher_role.rights << save_article_edits
#publisher_role.rights << update_article
#publisher_role.rights << show_unpub_article
#
#commenter_role.rights << new_comment
#commenter_role.rights << publish_comment
#commenter_role.rights << edit_comment
#commenter_role.rights << update_comment
#commenter_role.rights << destroy_comment
#
#admin_role.rights << admin
#admin_role.rights << admin_logout
#admin_role.rights << show_users
#admin_role.rights << users_index
#admin_role.rights << edit_user
#admin_role.rights << update_user
#

publisher_role.save
commenter_role.save
admin_role.save

#now, set up a couple of users
super_user = User.create({:username => "hmfic", :email => "admin@roblog.com", :last_name => "9000", :first_name => "Hal" })
super_user.password = "Zaq!2wsX"
super_user.save

#commenter = User.create({:username => "comment", :email => "comments@roblog.com"})
#commenter.password = "password"
#commenter.save
#
#publisher = User.create({:username => "robrob", :email => "rob@roblog.com"})
#publisher.password = "password"
#publisher.save
#
##set up their roles
#commenter.roles << commenter_role
#commenter.save
#
#publisher.roles << publisher_role
#publisher.roles << commenter_role
#publisher.save
#
super_user.roles << admin_role
super_user.roles << publisher_role
super_user.roles << commenter_role
super_user.save

