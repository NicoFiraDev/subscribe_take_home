class TaxCalculator
  attr_reader :category, :is_imported, :price

  SALES_TAXES_EXEMPTIONS = %w(books food medicine)

  def get_total_taxes(products)
    taxes_total = 0
    products.each do |product|
      sales_taxes = get_sales_taxes(product.category, product.price.to_f)
      duty_taxes = get_duty_taxes(product.is_imported, product.price.to_f)
      taxes_total = taxes_total + sales_taxes + duty_taxes
    end
    taxes_total
  end

  def get_price_with_taxes(category, is_imported, price)
    sales_taxes = get_sales_taxes(category, price)
    duty_taxes = get_duty_taxes(is_imported, price)

    price + sales_taxes + duty_taxes
  end

  def get_sales_taxes(category, price)
    return 0 if SALES_TAXES_EXEMPTIONS.include? category

    price.to_f * 0.1
  end

  def get_duty_taxes(is_imported, price)
    return 0 unless is_imported

    price.to_f * 0.05
  end
end
