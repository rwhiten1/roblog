class Right < ActiveRecord::Base
  has_and_belongs_to_many :roles #, :join_table => "table_name", :foreign_key => "roles #_id"
end
