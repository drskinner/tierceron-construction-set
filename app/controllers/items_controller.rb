class ItemsController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :vnum
    direction = params[:direction] || :asc

    @items = Item.accessible_by(current_ability)
                 .search(params.slice(:by_item_type, :by_zone_id, :keywords_contain))
    @full_count = @items.count

    @items = @items.order(sort => direction)
                   .page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    # Resolve bitvectors
    (0..5).each do |i|
      if params[:item]["value#{i}"].kind_of?(Array)
        params[:item]["value#{i}"] = List.sum_bitvector(params[:item]["value#{i}"])
      end
    end

    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    # Resolve bitvectors
    (0..5).each do |i|
      if params[:item]["value#{i}"].kind_of?(Array)
        params[:item]["value#{i}"] = List.sum_bitvector(params[:item]["value#{i}"])
      end
    end

    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end

  def import
    if params[:item].blank?
      flash[:error] = I18n.t('flash.error.upload_file_required')
    else
      count = ItemService.import(params[:item][:import_file].path)
      flash[:success] = I18n.t('flash.success.items_added', count: count)
    end

    redirect_to items_path
  end

  def value_labels
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: { labels: ItemService.value_labels(params[:item_type]) }
        }
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:vnum,
                                 :keywords,
                                 :item_type,
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
