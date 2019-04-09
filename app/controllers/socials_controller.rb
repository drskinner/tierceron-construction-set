class SocialsController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :id
    direction = params[:direction] || :asc

    @socials = Social.accessible_by(current_ability)
                     .order(sort => direction)
                     .page(params[:page])
  end

  def show
    @social = Social.find(params[:id])
  end

  def new
    @social = Social.new
  end

  def create
    @social = Social.new(social_params)

    if @social.save
      redirect_to @social
    else
      render 'new'
    end
  end

  def edit
    @social = Social.find(params[:id])
  end

  def update
    @social = Social.find(params[:id])

    if @social.update(social_params)
      redirect_to @social
    else
      render 'edit'
    end
  end

  def destroy
    @social = Social.find(params[:id])
    @social.destroy

    redirect_to socials_path
  end

  def import
    if params[:social].blank?
      flash[:error] = I18n.t('flash.error.upload_file_required')
    else
      count = SocialService.import(params[:social][:import_file].path)
      flash[:success] = I18n.t('flash.success.socials_added', count: count)
    end

    redirect_to socials_path
  end

  private

  def social_params
    params.require(:social).permit(:name,
                                   :char_no_arg,
                                   :others_no_arg,
                                   :char_obj,
                                   :others_obj,
                                   :char_found,
                                   :others_found,
                                   :vict_found,
                                   :char_auto,
                                   :others_auto)
  end

end