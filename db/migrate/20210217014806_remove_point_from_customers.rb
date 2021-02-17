class RemovePointFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :point, :integer
  end
end
