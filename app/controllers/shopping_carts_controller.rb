class ShoppingCartsController < ApplicationController

  def index
    shopping_carts = []
    subtotal = 0
    quantity = 0
    current_customer.shopping_carts.each do |item|
      if !item.product.nil?
        shopping_carts.push(item)
      else
        # /        
      end      
    end 

    if !shopping_carts.nil?
     shopping_carts.each do |item|
     item.total = item.product.price * item.quantity 
     subtotal += item.total
     quantity += item.quantity
     end
    else
      # /        
    end      
    
    render json: {
      subtotal: subtotal,
      quantity: quantity,
      shopping_carts: shopping_carts
    }, status: 200
  end

  def create
    @shopping_cart = ShoppingCart.new
    @shopping_cart.customer = current_customer
    puts "-------------#{current_customer.email}  njkjkhjbjhbffffffffffff----------"
    
    product = Product.find_by(id: params[:product_id])
    raise ActiveRecord::RecordNotFound.new("Product was not found") if product.nil?
    puts "-------------#{product.price}  ----------"
    puts "-------------#{params[:product_id]}--------------"
    
    @shopping_cart.product = product
    @shopping_cart.quantity = params[:quantity]

    
    existing_shopping_cart = ShoppingCart.where(customer: current_customer, product: product).first if !@shopping_cart.nil?
    
    unless existing_shopping_cart.nil?
      existing_shopping_cart.quantity += params[:quantity]
      existing_shopping_cart.save  
      
      return render json: @shopping_cart , status: 200    
    end

    if @shopping_cart.save
      render json: @shopping_cart , status: 200
      nil      
    end
  end

  private

  def shopping_carts_params
    params.require(:shopping_cart).permit(:customer_id)
  end

end
