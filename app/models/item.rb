class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :shipping_area
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image
  has_one :order

  with_options presence: { message: 'を入力してください' } do
    validates :image
    validates :name
    validates :detail
    validates :price
  end

  validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください', allow_blank: true }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は300~9,999,999円の範囲で入力してください', allow_blank: true }

  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :shipping_area_id
    validates :shipping_date_id
  end
end
