class Address < ApplicationRecord
  belongs_to :order

  with_options presence: true do
    validates :zip_code
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street
    validates :phone
  end
end
