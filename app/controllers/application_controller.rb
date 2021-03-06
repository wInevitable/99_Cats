class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  helper_method :current_user, :signed_in?
  
  private
  
  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end
  
  def sign_in(user)
    @current_user = user
    session[:token] = user.reset_session_token!
  end
  
  def signed_in?
    !!current_user
  end
  
  def sign_out
    current_user.try(:reset_session_token!)
    session[:token] = nil
  end
  
  def require_signed_in!
    if !signed_in?
      flash.now[:error] = 'Must be signed in'
      redirect_to new_session_url
    end
  end

  def require_signed_out!
    if signed_in?
      flash.now[:error] = 'Already signed in'
      redirect_to root_url 
    end
  end
end
