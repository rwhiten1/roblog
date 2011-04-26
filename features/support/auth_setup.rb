#This file is being used to setup the rights and role for user authoriztion
#agains various controllers and actions.  This will hopefully help to unclutter
#the tests.

#first, delete all the Rights and Roles
Role.delete_all
Right.delete_all
User.delete_all

#create the rights
Factory.create(:right, {:name => "New Comment"          ,:controller => "comments"      ,:action => "new"        })
Factory.create(:right, {:name => "Publish Comment"      ,:controller => "comments"      ,:action => "create"     })
Factory.create(:right, {:name => "Edit Comment"         ,:controller => "comments"      ,:action => "edit"       })
Factory.create(:right, {:name => "Update Comment"       ,:controller => "comments"      ,:action => "update"     })
Factory.create(:right, {:name => "Destroy Comment"      ,:controller => "comments"      ,:action => "destroy"    })
Factory.create(:right, {:name => "Update User"          ,:controller => "users"         ,:action => "update"     })
Factory.create(:right, {:name => "Edit User"            ,:controller => "users"         ,:action => "edit"       })
Factory.create(:right, {:name => "New Article"          ,:controller => "admin_console" ,:action => "new"        })
Factory.create(:right, {:name => "Publish Article"      ,:controller => "admin_console" ,:action => "create"     })
Factory.create(:right, {:name => "Edit Article"         ,:controller => "admin_console" ,:action => "edit"       })
Factory.create(:right, {:name => "Save Article Edits"   ,:controller => "admin_console" ,:action => "save_edits" })
Factory.create(:right, {:name => "Update Article"       ,:controller => "admin_console" ,:action => "update"     })
Factory.create(:right, {:name => "Admin Console"        ,:controller => "admin_console" ,:action => "index"      })
Factory.create(:right, {:name => "Show Unpubed Article" ,:controller => "admin_console" ,:action => "show"       })
Factory.create(:right, {:name => "Admin Logout"         ,:controller => "admin_console" ,:action => "index"      })
Factory.create(:right, {:name => "Show Users"           ,:controller => "users"         ,:action => "show"       })
Factory.create(:right, {:name => "Users Index"          ,:controller => "users"         ,:action => "index"      })
#Create the Roles
role = Factory.create(:role_with_rights,:name => "Commenter", :rights => [Right.find_by_name("New Comment")])
role.rights <<  Right.find_by_name("New Comment"        )
role.rights <<  Right.find_by_name("Publish Comment"    )
role.rights <<  Right.find_by_name("Edit Comment"       )
role.rights <<  Right.find_by_name("Update Comment"     )
role.rights <<  Right.find_by_name("Destroy Comment"    )
role.rights <<  Right.find_by_name("Update User"        )
role.rights <<  Right.find_by_name("Edit User"          )
role2 = Factory.create(:role_with_rights,:name => "Publisher", :rights => [Right.find_by_name("New Article")])
role2.rights << Right.find_by_name("New Article"        )
role2.rights << Right.find_by_name("Publish Article"    )
role2.rights << Right.find_by_name("Edit Article"       )
role2.rights << Right.find_by_name("Save Article Edits" )
role2.rights << Right.find_by_name("Update Article"     )
role2.rights << Right.find_by_name("Show Unpubed Article")
role3 = Factory.create(:role_with_rights,:name => "Superuser", :rights => [Right.find_by_name("Admin Console")])
role3.rights << Right.find_by_name("Admin Console"      )
role3.rights << Right.find_by_name("Admin Logout"       )
role3.rights << Right.find_by_name("Show Users"         )
role3.rights << Right.find_by_name("Users Index"        )