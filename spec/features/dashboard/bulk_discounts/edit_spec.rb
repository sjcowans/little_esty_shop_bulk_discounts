require 'rails_helper'

RSpec.describe 'merchant bulk discounts index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @bulk_discount_1 = @merchant1.bulk_discounts.create!(percent_discount: 20.0, quantity_threshold: 10)
    @bulk_discount_2 = @merchant1.bulk_discounts.create!(percent_discount: 30.0, quantity_threshold: 50)
  end

  it 'auto links to form' do
    visit merchant_bulk_discount_path(@merchant1, @bulk_discount_1)
    expect(page).to have_content("Bulk Discount #{@bulk_discount_1.id}")
    expect(page).to have_content("Discount: 20.0")
    expect(page).to have_content("Required quantity: 10")

    click_link "Update Bulk Discount"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1))
  end

  it 'has prefilled info' do
    visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1)

    expect(page).to have_field('Percent discount', with: "#{@bulk_discount_1.percent_discount}")
    expect(page).to have_field('Quantity threshold', with: "#{@bulk_discount_1.quantity_threshold}")
    expect(page).to have_no_content(@bulk_discount_2.quantity_threshold)
    expect(page).to have_no_content(@bulk_discount_2.percent_discount)
  end

  it 'will check valdiations' do
    visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1)

    fill_in 'Percent discount', with: ""
    fill_in 'Quantity threshold', with: "Five"
    click_on 'Update Bulk discount'
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1))
    within '#flash_message' do
      expect(page).to have_content("Error: Percent discount can't be blank, Percent discount is not a number, Quantity threshold is not a number")
    end
  end

  it 'can udpate and save' do
    visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1)

    fill_in 'Percent discount', with: "15.0"
    fill_in 'Quantity threshold', with: "5"
    click_on 'Update Bulk discount'

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount_1))
    expect(page).to have_content("Bulk Discount #{@bulk_discount_1.id}")
    expect(page).to have_content("Discount: 15.0")
    expect(page).to have_content("Required quantity: 5")
    expect(page).to have_no_content("Discount: 20.0")
    expect(page).to have_no_content("Required quantity: 10")
  end
end