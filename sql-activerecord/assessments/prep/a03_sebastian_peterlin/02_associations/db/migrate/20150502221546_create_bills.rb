class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :title
      t.integer :author_id, index: true

      t.timestamps
    end
  end
end
