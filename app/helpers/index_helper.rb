module IndexHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    if column == params[:sort]
      css_class = "sorted-#{params[:direction]}"
      direction = (params[:direction] == 'asc') ? 'desc' : 'asc'
    else
      css_class = 'sortable'
      direction = 'asc'
    end

    raw '<th class="sortable">' +
        (link_to I18n.t("sortable.#{controller_name}.#{column}"), 
         request.query_parameters.merge(sort: column, 
                                        direction: direction, 
                                        page: nil), 
         { class: css_class }) +
        '</th>'
  end

  def pagination_info(page:, page_count:, full_count:)
    return 'No records.' if full_count.zero?

    page ||= 1
    my_start = (page.to_i - 1) * 20 + 1
    raw "Displaying #{my_start}&ndash;#{my_start + page_count - 1} of #{full_count} records."
  end
end
