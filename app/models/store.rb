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
class Store < ApplicationRecord
  validates :name, :address, :description, presence: true
  validates_uniqueness_of :name
<<<<<<< HEAD
  has_many :items
=======
>>>>>>> store
end
