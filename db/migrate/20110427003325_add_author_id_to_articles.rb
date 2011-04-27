class AddAuthorIdToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :author_id, :integer
    execute "ALTER TABLE articles ADD CONSTRAINT articles_authors_fk FOREIGN KEY(author_id) REFERENCES authors(id)"
  end

  def self.down
    remove_column :articles, :author_id
  end
end
