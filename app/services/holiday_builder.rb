require 'httparty'
require 'json'
require './app/services/holiday_service.rb'
require './app/poros/holiday.rb'

class HolidayBuilder
  def self.service
    HolidayService.new
  end

  def self.holidays
    Holiday.new(service.get_holiday)
  end
end