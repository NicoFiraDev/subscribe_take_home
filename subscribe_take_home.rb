require './product'
require './shopping_cart'

@selected_products = []

def get_product_data_from_user
  puts "Select the product you want to buy from the following list:"
  puts Product.names_with_id

  id = gets.chomp.to_i
  data = {}

  if id == 0 || id > Product.all_options.size
    puts "Please enter a valid product id"
    get_product_data_from_user
  end

  data[:id] = id
  
  get_product_price(data)
end

def get_product_price(product_data)
  puts "What is the product price?"
  price = gets.chomp.to_f

  if price == 0
    puts "Please enter a valid price"
    get_product_price(product_data)
  end

  product_data[:price] = price
  get_product_quantity(product_data)
end

def get_product_quantity(product_data)
  puts "How much of this item do you want?"
  quantity = gets.chomp.to_i

  if quantity == 0
    puts "Please enter a valid quantity"
    get_product_quantity(product_data)
  end

  product_data[:quantity] = quantity

  new_product = Product.new(product_data)
  @selected_products << new_product

  select_another_product
end

def select_another_product
  puts "Do you want to select another product? Yes/no"
  select_another_product = gets.chomp

  if select_another_product == "Yes"
    get_product_data_from_user
  end
end

get_product_data_from_user
shopping_cart = ShoppingCart.new(products: @selected_products)
puts "printing receipt..."
shopping_cart.generate_receipt
