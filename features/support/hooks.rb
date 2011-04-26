#after hook
After do |scenario|
  User.delete_all
end