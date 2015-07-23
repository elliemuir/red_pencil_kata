class Item

  attr_accessor :base_price, :current_price, :last_price_change, :last_promotion_start_date,
                :is_currently_red_pencil_promotion, :number_of_days_on_current_promotion

  def initialize
    @base_price = 100.0
    @current_price = 100.0
    @last_price_change = Date.today - 31
    @last_promotion_start_date = Date.today - 31
    @is_currently_red_pencil_promotion = false
    @number_of_days_on_current_promotion = 0
  end

  def reduce_price(percentage)
    @current_price -= @current_price*(percentage.to_f/100)
    percent_off = ((@base_price - @current_price)/@base_price) * 100
    if percent_off > 5 && percent_off < 30
      if @last_price_change < (Date.today - 30) && @last_promotion_start_date < (Date.today - 30)
        trigger_red_pencil_promotion unless @is_currently_red_pencil_promotion
      end
    else
      cancel_red_pencil_promotion if @is_currently_red_pencil_promotion
    end
    @last_price_change = Date.today
  end

  def increase_price(percentage)
    @current_price += @current_price*(percentage.to_f/100)
    cancel_red_pencil_promotion if @is_currently_red_pencil_promotion
  end

  def add_day
    @number_of_days_on_current_promotion += 1
    cancel_red_pencil_promotion if @number_of_days_on_current_promotion > 30
  end

  def trigger_red_pencil_promotion
    @is_currently_red_pencil_promotion = true
    @last_promotion_start_date = Date.today
    @number_of_days_on_current_promotion = 1
  end

  def cancel_red_pencil_promotion
    @is_currently_red_pencil_promotion = false
    @last_promotion_start_date = Date.today
    @number_of_days_on_current_promotion = 0
  end


end