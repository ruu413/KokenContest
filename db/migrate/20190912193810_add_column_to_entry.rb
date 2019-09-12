class AddColumnToEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :on_ranking, :boolean, default: true, null: false
  end
end
