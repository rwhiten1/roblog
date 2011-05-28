class ChangeBodyhtmlToText < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.change :body_html, :text
    end
  end

  def self.down
    change_table :articles do |t|
      t.change :body_html, :string
    end
  end
end
