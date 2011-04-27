class AddUserIdToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :user_id, :integer
    execute "ALTER TABLE articles ADD CONSTRAINT articles_users_fk FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE"
  end

  def self.down
    execute "ALTER TABLE articles DROP FOREIGN KEY articles_users_fk"
    remove_column :articles, :user_id
  end
end
