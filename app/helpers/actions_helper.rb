module ActionsHelper
  def build_action
    controllers_with_actions = %w[helps items mobiles progs rooms skills spells socials users zones]
    model_name = I18n.t("activerecord.models.#{controller_name.singularize}")

    if (controllers_with_actions.include?(controller_name))
      if ((action_name == 'index') && (can? :create, controller_name.classify.constantize))
        { label: I18n.t('action.new', model: model_name),
          url: url_for(controller: controller_name, action: :new) }
      elsif ((action_name == 'show') && (can? :edit, eval("@#{controller_name.singularize}")))
        { label: I18n.t('action.edit', model: model_name),
          url: url_for(controller: controller_name, action: :edit, id: params[:id]) }
      end
    end
  end
end
