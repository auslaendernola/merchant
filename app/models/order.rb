class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  PAYMENT_TYPES = ["Check", "Credit Card", "PayPal", "Wampum", "Smiles"]
  validates :pay_type, inclusion: PAYMENT_TYPES
end
