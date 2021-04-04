class RenameAgeColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :Age, :age
  end
end
