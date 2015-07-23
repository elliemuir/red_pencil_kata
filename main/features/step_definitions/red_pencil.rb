require_relative('../../src/item')
require 'date'

Given(/^the price of my item was last changed (\d+) days ago$/) do |num|
  $item.last_price_change = Date.today - num.to_i
end

And(/^my item is( not)? currently marked as a red pencil promotion$/) do |negate|
  negate ? $item.is_currently_red_pencil_promotion = false : $item.is_currently_red_pencil_promotion = true
end

When(/^I reduce the price of my item by (\d+)%$/) do |percent|
  $item.current_price = $item.reduce_price(percent)
end

Then(/^the item should (now|not) be tagged as a red pencil promotion$/) do |now_or_not|
  if now_or_not == "now"
    fail "Item was not flagged as red pencil promotion" unless $item.is_currently_red_pencil_promotion
  elsif now_or_not == "not"
    fail "Item flagged as red pencil promotion" if $item.is_currently_red_pencil_promotion
  end
end

Given(/^I have an item for sale on the website$/) do
  $item = Item.new
end