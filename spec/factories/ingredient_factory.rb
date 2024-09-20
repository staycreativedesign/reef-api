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
FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    quantity  { Faker::Number.within(range: 1..10) }
    association :item
  end
end
