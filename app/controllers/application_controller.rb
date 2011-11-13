class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  
  protected
  
  def authorize
    if User.count.zero?
      redirect_to new_user_path, :notice => "Please create a user"
      return
    end
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end
  
end
