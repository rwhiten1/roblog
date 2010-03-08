class ArticleHasManyComments < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE comments ADD CONSTRAINT articles_fk FOREIGN KEY(article_id) REFERENCES articles(id) ON DELETE CASCADE"
  end

  def self.down
    execute "ALTER TABLE tasks DROP FOREIGN KEY articles_fk"
  end
end
