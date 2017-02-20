class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def subtotal
    # SQL Version
    line_items.select("SUM(quantity * price) AS sum")[0].sum
    # Ruby Version
    # line_items.to_a.sum do |item|
    #   item.total
    # end
  end
end
