# == Schema Information
#
# Table name: stores
#
#  id          :bigint           not null, primary key
#  address     :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :store do
    name { Faker::Restaurant.name }
    address  { Faker::Address.full_address }
    description { Faker::Restaurant.description }
  end
end
