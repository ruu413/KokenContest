class AddColumnToEntry2 < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :is_evaluated, :boolean, default: true, null: false
  end
end
