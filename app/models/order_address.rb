class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :street, :building, :phone, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :zip_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'にはハイフォン(-)を含め、半角英数字で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :city
    validates :street
    validates :phone, format: { with: /\A[0-9]+\z/, message: 'は半角英数字のみで入力してください' }
    validates :token
  end
  validates :phone, length: { in: 10..11, message: 'が短すぎます' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(order_id: order.id, zip_code: zip_code, prefecture_id: prefecture_id, city: city, street: street,
                   building: building, phone: phone)
  end
end
