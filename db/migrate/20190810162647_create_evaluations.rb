class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.integer :school_num,:null => false
      t.integer :evaluate1,:null => false
      t.integer :evaluate2,:null => false
      t.integer :evaluate3,:null => false
      t.string :evaluate4,:default => 0

      t.text :comment
      
      t.integer :entry_id
      t.timestamps
    end
  end
end
