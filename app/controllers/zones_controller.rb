class ZonesController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :id
    direction = params[:direction] || :asc

    @zones = Zone.accessible_by(current_ability)
                 .search(params.slice(:name_contains, :by_owner_id))
    @full_count = @zones.count

    @zones = @zones.order(sort => direction)
                   .page(params[:page])
  end

  def show
    @zone = Zone.find(params[:id])
  end

  def new
    @zone = Zone.new
  end

  def create
    @zone = Zone.new(zone_params)
 
    if @zone.save
      redirect_to @zone
    else
      render 'new'
    end
  end

  def edit
    @zone = Zone.find(params[:id])
  end

  def update
    @zone = Zone.find(params[:id])

    if @zone.update(zone_params)
      redirect_to @zone
    else
      render 'edit'
    end
  end

  def destroy
    @zone = Zone.find(params[:id])
    @zone.destroy

    redirect_to zones_path
  end

  private

  def zone_params
    params.require(:zone).permit(:name,
                                 :filename,
                                 :author,
                                 :owner_id,
                                 :min_vnum,
                                 :max_vnum)
  end

end
