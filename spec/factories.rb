require "#{Rails.root}/app/models/right"


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
  u.last_name {"Smith"}
  u.first_name {"John"}
  u.password {"password"}
end

Factory.define :article do |a|
  a.sequence(:title) { |n| "Article #{n}"}
  a.synopsis {"This is a test article"}
  a.body {"This is the body of the article"}
  a.published {false}
end




