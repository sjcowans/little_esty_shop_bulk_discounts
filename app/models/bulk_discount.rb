class BulkDiscount < ApplicationRecord
  validates :percent_discount, presence: true, numericality: true
  validates :quantity_threshold, presence: true, numericality: { only_integer: true }
  validates :merchant_id, presence: true

  belongs_to :merchant
end