class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id)
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :postal_code, :address)
  end
end
