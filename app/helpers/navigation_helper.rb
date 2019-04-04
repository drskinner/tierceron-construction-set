module NavigationHelper

  NAV_CONTROLLERS = %w[ Social User ]

  def nav_items
    NAV_CONTROLLERS.each_with_object([]) { |c, memo| memo << c.pluralize if can? :read, c.constantize; puts c }
  end
end

    