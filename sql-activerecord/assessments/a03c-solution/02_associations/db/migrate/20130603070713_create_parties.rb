class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.string :color
      t.integer :ideology_id
      t.integer :party_leader_id

      t.timestamps
    end
  end
end
