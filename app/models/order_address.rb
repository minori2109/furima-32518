class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :shipping_area_id, :city, :block, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly' }
    validates :city
    validates :block
    validates :phone_number, numericality: { only_integer: true, message: 'Input only number' }
    validates :token
  end

  validates :phone_number, length: { maximum: 11 }
  validates :shipping_area_id, numericality: { other_than: 1, message: 'Select' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, shipping_area_id: shipping_area_id, city: city, block: block, building: building, phone_number: phone_number, order_id: order.id)
  end
end
