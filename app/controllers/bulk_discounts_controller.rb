class BulkDiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.new(discount_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path
      flash[:alert] = "Discount created successfully!"
    else 
      redirect_to new_merchant_bulk_discount_path(@merchant)
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end

  private

  def discount_params
    params.permit(:id, :percent_discount, :quantity_threshold, :merchant_id)
  end
end