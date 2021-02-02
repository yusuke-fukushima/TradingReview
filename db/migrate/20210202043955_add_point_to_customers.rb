class AddPointToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :point, :integer
  end
end
