class RmColFromTable < ActiveRecord::Migration
  def change
  	remove_column :traces ,:logTime
  	add_column :traces, :logtime ,:datetime
  end
end
