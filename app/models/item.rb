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
  has_one :order
  # /ActiveHash以外のアソシエーション

  # ActiveHashのバリデーション
  with_options presence: true, numericality: { other_than: 1, message: "を入力してください" } do
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
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'が不正な値です' }
  end
  validates :price, numericality: { only_integer: true, message: 'は半角英数字で入力してください' }
  # /ActiveHash以外のバリデーション
end
