class Role < ActiveRecord::Base
  has_and_belongs_to_many :users #, :join_table => "table_name", :foreign_key => "users #_id"
  has_and_belongs_to_many :rights #, :join_table => "table_name", :foreign_key => "rights #_id"
  
  def get_unassigned_rights
    all_rights = Right.all
    unused = all_rights - @rights
    unused
  end
  
end
