ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    html_tag.sub! 'form-control', 'form-control is-invalid'
    html_tag.html_safe
  end