class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :teamname, :null => false
      t.integer :type, :null=> false
      t.text :description
      t.integer :evaluation, :defalut => 0
      t.integer :order, :default => 0
      t.integer :evaoder, :default => 0
      
      t.string :password_digest
      t.timestamps
    end
  end
end
