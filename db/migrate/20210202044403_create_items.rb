class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :detail
      t.string :image_id
      t.boolean :is_valid

      t.timestamps
    end
  end
end
