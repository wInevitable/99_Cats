class CatsController < ApplicationController
  #before_action :require_owner!, :only => [:edit, :update]
  before_action :require_signed_in!, :only => [:new, :create]
  
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
    @cat_rental_requests = @cat.cat_rental_requests.order(:start_date)
  end

  def new
    @cat = Cat.new
  end

  def edit
    @cat = current_user.cats.find(params[:id])
  end
  
  def create
    @cat = current_user.cats.new(cat_params)
    
    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      render :new
    end
  end

  def update
    @cat = current_user.cats.find(params[:id])
    
    if @cat.update(cat_params)
      redirect_to cat_url(@cat.id)
    else
      render :edit
    end
  end

  def destroy
  end
  
  private
  
  def cat_params
    params.require(:cat).permit(:name, :age, :birth_date, :sex, :color)
  end
  
  def require_owner!
    @cat = Cat.find(params[:id])
    if @cat.user_id != current_user.id
      flash.now[:error] = 'Must own cat.'
      redirect_to root_url
    end
  end
end
