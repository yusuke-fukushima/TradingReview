class AddAgeToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :Age, :integer
  end
end
