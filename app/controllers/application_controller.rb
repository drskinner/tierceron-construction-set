class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_current_user

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      flash[:error] = exception.message
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to welcome_index_path }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def set_current_user
    User.current = current_user
  end

  def after_sign_in_path_for(resource_or_scope)
    welcome_index_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
