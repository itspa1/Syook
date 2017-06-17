class CreateTraces < ActiveRecord::Migration
  def change
    create_table :traces do |t|
      t.integer :card_id
      t.integer :reader_id
      t.integer :strength
      t.time :logTime

      t.timestamps null: false
    end
  end
end
