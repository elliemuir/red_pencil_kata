class Item

  attr_accessor :base_price, :current_price, :last_price_change, :last_promotion_start_date, :is_currently_red_pencil_promotion

  def initialize
    @base_price = 100.0
    @current_price = 100.0
    @last_price_change = Date.today - 31
    @last_promotion_start_date = Date.today - 31
    @is_currently_red_pencil_promotion = false
  end

  def reduce_price(percentage)
    @current_price -= @current_price*(percentage.to_f/100)
    percent_off = ((@base_price - @current_price)/@base_price) * 100
    if percent_off > 5 && percent_off < 30
      if @last_price_change < (Date.today - 30) && @last_promotion_start_date < (Date.today - 30)
        @is_currently_red_pencil_promotion = true
      end
    else
      @is_currently_red_pencil_promotion = false
    end
    @last_price_change = Date.today
  end


end