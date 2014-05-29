class SessionsController < ApplicationController
  
  before_action :require_signed_out!, :only => [:new, :create]
  before_action :require_signed_in!, :only => [:destroy]
  
  def new #sign-in page
  end
  
  def create
    @user = User.find_by_credentials(
      user_params[:user_name],
      user_params[:password]    
    )
    
    if @user 
      sign_in(@user)
      redirect_to root_url
    else
      flash.now[:error] = "Invalid credentials. Try again."
      render :new
    end
  end
  
  def destroy
    sign_out
    redirect_to new_session_url
  end
  
  def user_params
    params.require(:user_params).permit(:user_name, :password)
  end
end
