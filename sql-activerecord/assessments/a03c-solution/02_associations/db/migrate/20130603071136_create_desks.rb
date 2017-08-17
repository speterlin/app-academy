class CreateDesks < ActiveRecord::Migration
  def change
    create_table :desks do |t|
      t.string :model
      t.integer :owner_id

      t.timestamps
    end
  end
end
