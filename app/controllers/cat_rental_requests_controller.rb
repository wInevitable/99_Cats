class CatRentalRequestsController < ApplicationController
  before_action :require_owner!, :only => [:approve, :deny]
  before_action :require_signed_in!, :only => [:new, :create]
  
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.where('user_id != ?', current_user.id)
  end
  
  def create
    @cat_rental_request = current_user.cat_rental_requests.new(cat_rental_request_params)
    
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      @cats = Cat.all
      render :new
    end
  end
  
  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end
  
  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end
  
  private
  
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
  
  def require_owner!
    @cat_rental_request = current_user.cat_rental_requests.find(params[:id])
  end
end
