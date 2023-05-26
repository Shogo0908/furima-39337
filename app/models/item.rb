class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true,  greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :delivery_fee_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_date_id, presence: true
  validates :image, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_date
end
