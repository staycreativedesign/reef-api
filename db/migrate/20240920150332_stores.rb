class Stores < ActiveRecord::Migration[7.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.text :description
      t.timestamps
    end
  end
end
