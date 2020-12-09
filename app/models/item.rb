class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status

  validates :category_id, :status_id, numericality: { other_than: 1 }
end
