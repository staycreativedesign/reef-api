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
class Item < ApplicationRecord
  validates :name, :price_cents, :description, presence: true
  validates_uniqueness_of :name, scope: :store_id
  validates :price_cents, numericality: { only_integer: true }

  belongs_to :store, dependent: :destroy
  has_many :ingredients
end
