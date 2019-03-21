class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_current_user

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
