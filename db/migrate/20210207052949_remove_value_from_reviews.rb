class RemoveValueFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :value, :float
  end
end
