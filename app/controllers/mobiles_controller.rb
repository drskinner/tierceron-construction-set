class MobilesController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :vnum
    direction = params[:direction] || :asc

    @mobiles = Mobile.accessible_by(current_ability)
                 .search(params.slice(:by_mobile_type, :by_zone_id, :keywords_contain))
    @full_count = @mobiles.count

    @mobiles = @mobiles.order(sort => direction)
                   .page(params[:page])

    respond_to do |format|
      format.html
      format.smaug do
        if (@zone = Zone.find_by(id: params[:by_zone_id]))
          filename = "#{Time.now.strftime('%Y%m%d_%H%M%S')}_mobiles_#{@zone.filename}.are"
          send_data MobileService.export(Mobile.accessible_by(current_ability)
                                           .by_zone_id(@zone.id)
                                           .order(vnum: :asc)),
                    type: 'text/plain; charset=UTF-8;',
                    disposition: "attachment; filename=#{Time.now.strftime('%Y%m%d_%H%M%S')}_mobiles.are"
        end
      end
    end
  end

  def new
    @mobile = Mobile.new
  end

  def create
    # Resolve bitvectors
    (0..5).each do |i|
      if params[:mobile]["value#{i}"].kind_of?(Array)
        params[:mobile]["value#{i}"] = List.sum_bitvector(params[:mobile]["value#{i}"])
      end
    end

    @mobile = Mobile.new(mobile_params)

    if @mobile.save
      redirect_to @mobile
    else
      render 'new'
    end
  end

  def show
    @mobile = Mobile.find(params[:id])
  end

  def edit
    @mobile = Mobile.find(params[:id])
  end

  def update
    @mobile = Mobile.find(params[:id])

    # Resolve bitvectors
    (0..5).each do |i|
      if params[:mobile]["value#{i}"].kind_of?(Array)
        params[:mobile]["value#{i}"] = List.sum_bitvector(params[:mobile]["value#{i}"])
      end
    end

    if @mobile.update(mobile_params)
      redirect_to @mobile
    else
      render 'edit'
    end
  end

  def destroy
    @mobile = Mobile.find(params[:id])
    @mobile.destroy

    redirect_to mobiles_path
  end

  def import
    if params[:mobile].blank?
      flash[:error] = I18n.t('flash.error.upload_file_required')
    else
      count = MobileService.import(params[:mobile][:import_file].path)
      flash[:success] = I18n.t('flash.success.mobiles_added', count: count)
    end

    redirect_to mobiles_path
  end

  def value_labels
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: { labels: MobileService.value_labels(params[:mobile_type]) }
        }
      end
    end
  end

  private

  def mobile_params
    params.require(:mobile).permit(:vnum,
                                 :keywords,
                                 :mobile_type,
                                 :short_desc,
                                 :long_desc,
                                 :full_desc,
                                 :value0,
                                 :value1,
                                 :value2,
                                 :value3,
                                 :value4,
                                 :value5,
                                 :weight,
                                 :cost,
                                 :rent,
                                 :level,
                                 :layers,
                                 flags: [],
                                 wear_flags: []
                                )
  end
end
