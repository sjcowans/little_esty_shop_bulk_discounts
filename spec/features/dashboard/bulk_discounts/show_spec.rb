require 'rails_helper'

RSpec.describe 'merchant bulk discount show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @bulk_discount_1 = @merchant1.bulk_discounts.create!(percent_discount: 20.0, quantity_threshold: 10)
    @bulk_discount_2 = @merchant1.bulk_discounts.create!(percent_discount: 30.0, quantity_threshold: 50)
    @bulk_discount_3 = @merchant1.bulk_discounts.create!(percent_discount: 50.0, quantity_threshold: 100)
    @bulk_discount_4 = @merchant2.bulk_discounts.create!(percent_discount: 20.0, quantity_threshold: 10)
  end

  it 'displays quantity threshold and percentage discount' do
    visit merchant_bulk_discount_path(@merchant1, @bulk_discount_1)

    expect(page).to have_content("Bulk Discount #{@bulk_discount_1.id}")
    expect(page).to have_no_content("Bulk Discount #{@bulk_discount_2.id}")
    expect(page).to have_no_content("Bulk Discount #{@bulk_discount_3.id}")
    expect(page).to have_content("Discount: #{@bulk_discount_1.percent_discount}")
    expect(page).to have_content("Required quantity: #{@bulk_discount_1.quantity_threshold}")


    visit merchant_bulk_discount_path(@merchant1, @bulk_discount_2)
    
    expect(page).to have_content("Bulk Discount #{@bulk_discount_2.id}")
    expect(page).to have_no_content("Bulk Discount #{@bulk_discount_3.id}")
    expect(page).to have_no_content("Bulk Discount #{@bulk_discount_1.id}")
    expect(page).to have_content("Discount: #{@bulk_discount_2.percent_discount}")
    expect(page).to have_content("Required quantity: #{@bulk_discount_2.quantity_threshold}")
  end
end