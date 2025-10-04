ActionView::Base.field_error_proc =  -> (html_tag, instance) {
    unless html_tag =~ /^<label/
        html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
        html.children.add_class("is-danger")

        error_message_markup = <<~HTML
            <p class="help is-danger">#{sanitize(instance.error_message.first)}</p>
        HTML

        "#{html.to_html}#{error_message_markup}".html_safe
    else
        html_tag
    end
}