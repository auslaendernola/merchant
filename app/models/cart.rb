class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # Increment Quantity if Product is already in Cart
  # Add new Line Item if Product is not in Cart
  def add_product(product_id)
    product = Product.find(product_id)
    current_item = @cart.add_product(product.id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product, price: product.price)
    end
    current_item
  end

  def subtotal
    # SQL Version
    line_items.select("SUM(quantity * price) AS sum")[0].sum
    # Ruby Version
    # line_items.to_a.sum do |item|
    #   item.total
    # end
  end
end
