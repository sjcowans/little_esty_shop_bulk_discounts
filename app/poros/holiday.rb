class Holiday
  attr_reader :holidays_info

  def initialize(holidays)
    @holidays_info = []
    holidays[0..3].each do |holiday_info|
      @holidays_info << holiday_info
    end
  end
end
