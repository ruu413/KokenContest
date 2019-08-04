class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :teamname
      t.string :names
      t.text :description

      t.timestamps
    end
  end
end
