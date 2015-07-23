require_relative('../../src/item')
require 'date'

Given(/^I have an item for sale on the website$/) do
  $item = Item.new
end

And(/^the price of my item was last changed (\d+) days ago$/) do |num|
  $item.last_price_change = Date.today - num.to_i
end

And(/^the last promotion start date was (\d+) days ago$/) do |num|
  $item.last_promotion_start_date = Date.today - num.to_i
end

And(/^my item has been marked as a red pencil promotion for (\d+) days$/) do |num|
  num_days = num.to_i
  $item.is_currently_red_pencil_promotion = true
  $item.number_of_days_on_current_promotion = num_days
  $item.last_promotion_start_date = Date.today - num_days
end

And(/^my item is( not)? currently marked as a red pencil promotion$/) do |negate|
  negate ? $item.is_currently_red_pencil_promotion = false : $item.is_currently_red_pencil_promotion = true
end

When(/^I reduce the price of my item by (\d+)%$/) do |percent|
  $item.current_price = $item.reduce_price(percent)
end

When(/^I increase the price of my item by (\d+)%$/) do |percent|
  $item.current_price = $item.increase_price(percent)
end

When(/^another day passes during the promotion$/) do
  $item.add_day
end

Then(/^the item should (now|not) be tagged as a red pencil promotion$/) do |now_or_not|
  if now_or_not == "now"
    fail "Item was not flagged as red pencil promotion" unless $item.is_currently_red_pencil_promotion
  elsif now_or_not == "not"
    fail "Item flagged as red pencil promotion" if $item.is_currently_red_pencil_promotion
  end
end

But(/^the last promotion start date should be (\d+) days ago$/) do |num|
  fail "The last promotion start date does not match the expected value of #{num}" unless $item.last_promotion_start_date == Date.today - num.to_i
end