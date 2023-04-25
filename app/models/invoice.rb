class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    total_invoice_discount = invoice_items
    .joins(:bulk_discounts)
    .where("quantity >= quantity_threshold")
    .select("invoice_items.*, MAX(quantity * invoice_items.unit_price * percent_discount / 100) as discounts")
    .group(:id)
    .sum(&:discounts)

    total_revenue - total_invoice_discount.round(2)
  end
end
