module BreadcrumbsHelper
  def build_breadcrumbs
    [].tap { |crumbs|
      case controller_name
      when 'registrations'
        if (action_name == 'index')
          crumbs << I18n.t('breadcrumb.users.index')
        elsif User.current
          crumbs << link_to(I18n.t('breadcrumb.users.index'), users_path)
        end

        case action_name
          when 'edit'
            crumbs << link_to("#{@user.name_display}", user_path(@user.id))
            crumbs << I18n.t('breadcrumb.registrations.edit')
          end

      when 'socials'
        if (action_name == 'index')
          crumbs << I18n.t('breadcrumb.socials.index')
        else
          crumbs << link_to(I18n.t('breadcrumb.socials.index'), socials_path)
        end

        case action_name
        when 'new'
          crumbs << I18n.t('breadcrumb.socials.new')
        when 'show'
          crumbs << "#{@social.name}"
        when 'edit'
          crumbs << link_to("#{@social.name}", social_path(@social))
          crumbs << I18n.t('breadcrumb.shared.edit')
        end

      when 'users'
        if (action_name == 'index')
          crumbs << I18n.t('breadcrumb.users.index')
        else
          crumbs << link_to(I18n.t('breadcrumb.users.index'), users_path)
        end

        case action_name
        when 'new'
          crumbs << I18n.t('breadcrumb.users.new')
        when 'show'
          crumbs << "#{@user.name_display}"
        when 'edit'
          crumbs << link_to("#{@user.name_display}", user_path(@user.id))
          crumbs << I18n.t('breadcrumb.shared.edit')
        end
      end
    }
  end
end
