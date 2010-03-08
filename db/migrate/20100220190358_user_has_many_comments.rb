class UserHasManyComments < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE comments ADD CONSTRAINT users_fk FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE"
  end

  def self.down
    execute "ALTER TABLE tasks DROP FOREIGN KEY users_fk"
  end
end
