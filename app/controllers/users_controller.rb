class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :id
    direction = params[:direction] || :asc

    # unsafe: .order("#{params[:sort]} #{params[:direction]}")
    @users = User.accessible_by(current_ability)
                 .search(params.slice(:name_contains, :by_role_id))
                 .order(sort => direction)
                 .page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
 
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(update_user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  private

  def create_user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :pronoun_class,
                                 :role_id,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def update_user_params
    permitted = %i[first_name last_name pronoun_class email]
    permitted << :role_id if current_user.gsa?

    params.require(:user).permit(permitted)
  end

end
