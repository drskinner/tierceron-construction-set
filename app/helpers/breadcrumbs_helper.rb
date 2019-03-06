module BreadcrumbsHelper
  def build_breadcrumbs
    [].tap { |crumbs|
      case controller_name
      when 'registrations'
        crumbs << (action_name == 'index' ? 'Users' : link_to('Users', users_path))
        case action_name
          when 'edit'
            crumbs << link_to("#{@user.name_display}", user_path(@user.id))
            crumbs << 'Edit Profile'
          end

      when 'users'
        crumbs << (action_name == 'index' ? 'Users' : link_to('Users', users_path))
        case action_name
        when 'new'
          crumbs << 'New User'
        when 'show'
          crumbs << "#{@user.name_display}"
        when 'edit'
          crumbs << link_to("#{@user.name_display}", user_path(@user.id))
          crumbs << 'Edit'
        end
      end
    }
  end
end
