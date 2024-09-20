class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.belongs_to :store
      t.string :name
      t.monetize :price
      t.text :description
      t.timestamps
    end
  end
end
