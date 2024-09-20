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
require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'associations' do
    it { should belong_to(:item).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:name).scoped_to(:item_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
  end
end
