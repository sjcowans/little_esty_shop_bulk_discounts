require 'rails_helper'

RSpec.describe 'destroy merchant bulk discounts' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @bulk_discount_1 = @merchant1.bulk_discounts.create!(percent_discount: 20.0, quantity_threshold: 10)
    @bulk_discount_2 = @merchant1.bulk_discounts.create!(percent_discount: 30.0, quantity_threshold: 50)
    @bulk_discount_3 = @merchant1.bulk_discounts.create!(percent_discount: 50.0, quantity_threshold: 100)
    @bulk_discount_4 = @merchant2.bulk_discounts.create!(percent_discount: 20.0, quantity_threshold: 10)
  end

  it 'can delete a bulk discount' do
    visit merchant_bulk_discounts_path(@merchant1)
    expect(page).to have_link("Bulk Discount #{@bulk_discount_1.id}")
    expect(page).to have_link("Bulk Discount #{@bulk_discount_2.id}")
    expect(page).to have_link("Bulk Discount #{@bulk_discount_3.id}")
    within "#bulk-discount-#{@bulk_discount_1.id}" do
      expect(page).to have_link "Delete Discount"
    end
    within "#bulk-discount-#{@bulk_discount_3.id}" do
      expect(page).to have_link "Delete Discount"
    end
    within "#bulk-discount-#{@bulk_discount_3.id}" do
      expect(page).to have_link "Delete Discount"
      click_link 'Delete Discount'
    end
    within "#flash_message" do
      expect(page).to have_content("Discount deleted successfully!")
    end
    expect(page).to have_no_link("Bulk Discount #{@bulk_discount_3.id}")
    expect(page).to have_link("Bulk Discount #{@bulk_discount_1.id}")
    expect(page).to have_link("Bulk Discount #{@bulk_discount_2.id}")
  end
end