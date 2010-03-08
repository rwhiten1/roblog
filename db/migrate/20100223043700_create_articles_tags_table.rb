class CreateArticlesTagsTable < ActiveRecord::Migration
  def self.up
    create_table :articles_tags, :id => false do |t|
      t.integer :article_id
      t.integer :tag_id
    end
    
    execute "ALTER TABLE articles_tags ADD CONSTRAINT article_fk FOREIGN KEY(article_id) REFERENCES articles(id)"
    execute "ALTER TABLE articles_tags ADD CONSTRAINT tag_fk FOREIGN KEY(tag_id) REFERENCES tags(id)"
  end

  def self.down
    execute "ALTER TABLE articles_tags DROP CONSTRAINT article_fk"
    execute "ALTER TABLE articles_tags DROP CONSTRAINT tag_fk"
    drop_table :articles_tags
  end
end
