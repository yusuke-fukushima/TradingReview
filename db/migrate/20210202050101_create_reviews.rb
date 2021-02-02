class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.float :value
      t.text :good_point
      t.text :bad_point
      t.text :improvement_point

      t.timestamps
    end
  end
end
