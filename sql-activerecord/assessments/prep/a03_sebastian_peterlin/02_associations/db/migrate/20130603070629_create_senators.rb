class CreateSenators < ActiveRecord::Migration
  def change
    create_table :senators do |t|
      t.string :fname
      t.string :lname
      t.string :state
      t.integer :party_id

      t.timestamps
    end
  end
end
