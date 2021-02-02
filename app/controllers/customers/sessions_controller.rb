class Customers::SessionsController < Devise::SessionsController
  def new_guest
    customer = Customer.guest
    sign_in customer
    redirect_to public_genres_path
  end
end