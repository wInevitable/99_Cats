class UsersController < ApplicationController
  
  before_action :require_signed_in!, :only => [:show]
  before_action :require_signed_out!, :only => [:create, :new]
  
  def new
    @user = User.new
  end

  def create
    if params[:user_params][:password] == params[:user_params][:password2]
      @user = User.new(user_params)
    
      if @user.save
        sign_in(@user)
        redirect_to root_url
      else
        flash.now[:errors] = @user.errors.full_messages
        render :new
      end
    else
      flash.now[:error] = "Passwords do not match."
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    if current_user.id == @user.id
      @my_cats = @user.cats
      @my_requests = @user.cat_rental_requests
    else
      redirect_to user_url(current_user.id)
    end
  end
  
  def user_params
    params.require(:user_params).permit(:user_name, :password)
  end
end
