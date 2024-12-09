# app/helpers/custom_form_builder.rb
class ProclasseFormBuilder < ActionView::Helpers::FormBuilder
  %i[text_field radio_button password_field email_field number_field text_area select].each do |method_name|
    define_method(method_name) do |args, named_args|
      named_args[:class] = [named_args[:class], 'input input-bordered w-full'].join(' ')
      super(*args, **named_args)
    end
  end

  def check_box(args, named_args)
    named_args[:class] = [named_args[:class], 'checkbox'].join(' ')
    super(*args, **named_args)
  end

  def submit(value = nil, options = {})
    options[:class] = [options[:class], 'btn btn-primary'].join(' ')
    super(value, options)
  end
end
