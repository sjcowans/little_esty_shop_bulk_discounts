class BulkDiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
    @holidays = HolidayBuilder.holidays
  end
  
  def destroy
    BulkDiscount.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
    flash[:alert] = "Discount deleted successfully!"
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.new(new_discount_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path
      flash[:alert] = "Discount created successfully!"
    else 
      redirect_to new_merchant_bulk_discount_path(@merchant)
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    if @bulk_discount.update(update_discount_params)
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
      flash[:alert] = "Discount updated successfully!"
    else
      redirect_to edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
      flash[:alert] = "Error: #{error_message(@bulk_discount.errors)}"
    end
  end

  private

  def update_discount_params
    params.require(:bulk_discount).permit(:id, :percent_discount, :quantity_threshold, :merchant_id)
  end

  def new_discount_params
    params.permit(:id, :percent_discount, :quantity_threshold, :merchant_id)
  end
end