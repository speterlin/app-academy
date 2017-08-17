class CreateIdeologies < ActiveRecord::Migration
  def change
    create_table :ideologies do |t|
      t.string :name
      t.string :direction
      t.string :goal

      t.timestamps
    end
  end
end
