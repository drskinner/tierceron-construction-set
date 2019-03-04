module ActionsHelper
  def build_action

    controllers_with_actions = %w[users]
#
# all the potential controllers:
#    controllers_with_actions = %w[helps, items, mobiles, progs, rooms, skills, spells, socials, users, zones]

    if (controllers_with_actions.include?(controller_name))
      case action_name
      when 'index'
        action = { label: I18n.t('action.new', model: controller_name.classify),
                   url: url_for(controller: controller_name, action: :new) }
      when 'show'
        action = { label: I18n.t('action.edit', model: controller_name.classify),
                   url: url_for(controller: controller_name, action: :edit, id: params[:id]) }
      end
    end

    action
  end
end
