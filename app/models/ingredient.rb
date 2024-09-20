# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  name       :string
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint
#
# Indexes
#
#  index_ingredients_on_item_id  (item_id)
#
class Ingredient < ApplicationRecord
  validates :name, :quantity, presence: true
  validates_uniqueness_of :name, scope: :item_id
  validates :quantity, numericality: { only_integer: true }

  belongs_to :item, dependent: :destroy
end
