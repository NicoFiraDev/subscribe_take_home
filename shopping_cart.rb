require './tax_calculator'

class ShoppingCart
  attr_reader :products

  def initialize(products:)
    @products = products
  end

  def generate_receipt
    get_product_details
    puts "Sales Taxes: $#{TaxCalculator.new.get_total_taxes(products).round(2)}"
    puts "Total: $#{get_total.round(2)}"
  end

  def get_product_details
    products.each do |p|
      puts p.description_for_printing
    end
  end

  def get_total
    total = 0
    products.each do |p|
      total = total + (p.calculate_price * p.quantity)
    end
    total
  end
end
