class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles #, :join_table => "table_name", :foreign_key => "articles #_id"
end
