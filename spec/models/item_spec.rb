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
require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:store).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:store_id) }
    it { should validate_presence_of(:price_cents) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price_cents) }
  end
end

