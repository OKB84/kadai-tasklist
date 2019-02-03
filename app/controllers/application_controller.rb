class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  
  private
  
  def require_user_logged_in
    unless logged_in?
      flash[:danger] = 'ログインして下さい'
      redirect_to login_url
    end
  end
end
