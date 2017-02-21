class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def new
    if @cart.line_items.empty?
      redirect_to shop_url, notice: "Your cart is empty."
      return
    end
    @order = Order.new
    @order.user_id = current_user.id
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.add_line_items_from_cart(@cart)

    if @order.save
      # destroy cart
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      # notice
      # redirect to shop
      redirect_to shop_url, notice: "Thank you for your Order!"
    else
      # try again
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :pay_type, :user_id)
  end
end
