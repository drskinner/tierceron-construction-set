class ShowInput < SimpleForm::Inputs::Base
  def input
    accessor_string = attribute_name.to_s
    if object.respond_to?(accessor_string + '_display')
      accessor = "#{accessor_string}_display".to_sym
    else
      accessor = accessor_string.to_sym
    end

    value = object.send(accessor)
    value = "<span class=\"no-data\">#{I18n.t('messages.no_data')}</span>".html_safe if value.blank?

    template.content_tag('div', value, { class: 'show-input' })
  end

  def additional_classes
    @additional_classes ||= [input_type].compact
  end
end
