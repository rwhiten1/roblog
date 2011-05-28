class ChangeBodyRawColumnInArticles < ActiveRecord::Migration
  def self.up
    rename_column :articles, :body_raw, :body_html
  end

  def self.down
    rename_column :articles, :body_html, :body_raw
  end
end
