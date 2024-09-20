# == Schema Information
#
# Table name: items
#
#  id             :bigint           not null, primary key
#  description    :text
#  name           :string
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("USD"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  store_id       :bigint
#
# Indexes
#
#  index_items_on_store_id  (store_id)
#
FactoryBot.define do
  factory :item do
    name { Faker::Restaurant.name }
    description  { Faker::Food.dish }
    price_cents { 613 }
    association :store
  end
end
