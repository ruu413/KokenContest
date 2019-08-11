class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :grade, :null => false
      t.string :name, :null => false
      t.text :description
      t.integer :entry_id

      t.timestamps
    end
  end
end
