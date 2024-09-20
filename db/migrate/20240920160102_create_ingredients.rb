class CreateIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredients do |t|
      t.belongs_to :item
      t.string :name
      t.integer :quantity
      t.timestamps
    end
  end
end
