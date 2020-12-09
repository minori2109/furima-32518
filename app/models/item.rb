class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :shipping_area
  belongs_to :shipping_date
  belongs_to :user

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :shipping_area_id
    validates :shipping_area_id
  end 
end
