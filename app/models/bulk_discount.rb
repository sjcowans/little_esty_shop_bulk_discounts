class BulkDiscount < ApplicationRecord
  validates_presence_of :percent_discount,
                        :quantity_threshold,
                        :merchant_id

  belongs_to :merchant
end