class Product
  attr_reader :id, :quantity, :price, :name, :category, :is_imported

  def initialize(id:, quantity: 0, price: 0)
    @id = id
    @quantity = quantity
    @name = get_name_by_id
    @category = get_category_by_id
    @is_imported = get_is_imported_by_id
    @price = price.to_f
  end

  def self.names_with_id
    Product.all_options.map do |opt|
      "#{opt[:name]}: #{opt[:id]}"
    end
  end

  def get_product_by_id
    Product.all_options.select { |opt| opt[:id] == id }.first
  end

  def get_name_by_id
    get_product_by_id[:name]
  end

  def get_category_by_id
    get_product_by_id[:category]
  end

  def get_is_imported_by_id
    get_product_by_id[:is_imported]
  end

  def calculate_price
    taxes_calculator = TaxCalculator.new
    taxes_calculator.get_price_with_taxes(category, is_imported, price)
  end

  def description_for_printing
    "#{quantity} #{name}: $#{calculate_price.round(2) * quantity}"
  end

  def self.all_options
    [
      {
        id: 1,
        name: 'book',
        category: 'books',
        is_imported: false,
      },
      {
        id: 2,
        name: 'music CD',
        category: 'music',
        is_imported: false,
      },
      {
        id: 3,
        name: 'chocolate bar',
        category: 'food',
        is_imported: false,
      },
      {
        id: 4,
        name: 'imported box of chocolate',
        category: 'food',
        is_imported: true,
      },
      {
        id: 5,
        name: 'imported bottle of perfume',
        category: 'personal_care',
        is_imported: true,
      },
      {
        id: 6,
        name: 'bottle of perfume',
        category: 'personal_care',
        is_imported: false,
      },
      {
        id: 7,
        name: 'packet of headache pills',
        category: 'medicine',
        is_imported: false,
      }
    ]
  end
end
