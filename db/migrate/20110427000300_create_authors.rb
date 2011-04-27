class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.integer :user_id
      t.string :pseudo_last
      t.string :pseudo_first

      t.timestamps
    end
    execute "ALTER TABLE authors ADD CONSTRAINT authors_users_fk FOREIGN KEY(user_id) REFERENCES users(id)"
  end

  def self.down
    execute "ALTER TABLE authors DROP FOREIGN KEY authors_users_fk"
    drop_table :authors
  end
end
