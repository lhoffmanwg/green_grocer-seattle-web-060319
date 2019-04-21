require 'pry'

def consolidate_cart(cart_ary)
 
  new_hash = {}

  cart_ary.each do |item|
    item.each do |item_name, data|
      
      if new_hash[item_name] == nil
        new_hash[item_name] = data
        new_hash[item_name][:count] = 1 
        #binding.pry
      else
        new_hash[item_name][:count] += 1
      end
    end
  end
 
  new_hash
  
end

def apply_coupons(cart_ary, coupons_ary)
 binding.pry
  new_hash = {}
  if coupons_ary == nil || coupons_ary.empty?
    new_hash = cart_ary
  end
  coupons_ary.each do |coupon|
    cart_ary.each do |itemname, data|
      if itemname == coupon[:item]
        count = data[:count] - coupon[:num]
        
        if count >= 0
          if my_hash["#{itemname} W/COUPON"] == nil
            my_hash["#{itemname} W/COUPON"] = {price: coupon[:cost], clearance: data[:clearance], count: 1}
          else
            couponcount = my_hash["#{itemname} W/COUPON"][:count] + 1
            my_hash["#{itemname} W/COUPON"] = {price: coupon[:cost], clearance: data[:clearance], count: couponcount}
          end
        else
          count = data[:count]
        end
        new_hash[itemname] = data
        new_hash[itemname][:count] = count
      else
        new_hash[itemname] = data
      end
    end
  end
  new_hash
end

def apply_clearance(cart:[])

  cart.each do |itemname, data|
    if data[:clearance]
      discount = data[:price] * 0.8
      data[:price] = discount.round(2)
    end
  end
  cart
end

def checkout(cart_ary, coupons_ary)
 
 
  cart = consolidate_cart(cart:cart)
  cart = apply_coupons(cart:cart, coupons:coupons)
  cart = apply_clearance(cart:cart)
  total = 0
  cart.each do |itemname, data|
    total += ( data[:price] * data[:count] )
  end
  if total > 100
    puts total
    total = total - (total * 0.1 )
    
  end
  total
end
