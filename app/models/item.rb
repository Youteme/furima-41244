class Item < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to :item_status
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_date

  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :image
  end

  validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :shipping_date_id
  end
end