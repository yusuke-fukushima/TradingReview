class RenameGenderColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :Gender, :gender
  end
end
