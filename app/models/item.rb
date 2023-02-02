class Item < ApplicationRecord
# ActiveHashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :payment
  belongs_to :prefecture
  belongs_to :lead_time
# /ActiveHashのアソシエーション

# ActiveHash以外のアソシエーション
  belongs_to :user
  has_one_attached :image
# /ActiveHash以外のアソシエーション


# ActiveHashのバリデーション
with_options presence: true, numericality: {other_than: 1, message: "can't be blank"} do
  validates :category_id
  validates :status_id
  validates :prefecture_id
  validates :payment_id
  validates :lead_time_id
end
# /ActiveHashのバリデーション

# ActiveHash以外のバリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price, numericality: {in: 300..9999999}
  end
# /ActiveHash以外のバリデーション
end
