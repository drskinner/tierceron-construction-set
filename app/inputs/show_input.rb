class ShowInput < SimpleForm::Inputs::Base

  def input(wrapper_options = {})
    accessor = object.respond_to?("#{attribute_name.to_s}_display") ?
      "#{attribute_name.to_s}_display" :
      attribute_name.to_s

    value = object.send(accessor.to_sym)
    value = "<span class=\"no-data\">#{I18n.t('messages.no_data')}</span>".html_safe if value.blank?

    template.content_tag('div', value, { class: 'show-input' })
  end

  def additional_classes
    @additional_classes ||= [input_type].compact
  end
end
