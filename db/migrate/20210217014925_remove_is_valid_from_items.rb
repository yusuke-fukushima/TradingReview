class RemoveIsValidFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :is_valid, :boolean
  end
end
