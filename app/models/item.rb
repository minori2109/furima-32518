class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :shipping_area

  validates :category_id, :status_id, :shipping_fee_id, :shipping_area_id, numericality: { other_than: 1 }
end
