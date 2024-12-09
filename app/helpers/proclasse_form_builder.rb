# app/helpers/custom_form_builder.rb
class ProclasseFormBuilder < ActionView::Helpers::FormBuilder
  %i[text_field password_field email_field number_field text_area select].each do |method_name|
    define_method(method_name) do |args, named_args|
      named_args[:class] = [named_args[:class], 'input input-bordered w-full'].join(' ')
      super(*args, **named_args)
    end
  end

  def submit(value = nil, options = {})
    options[:class] = [options[:class], 'btn btn-primary'].join(' ')
    super(value, options)
  end

  # def select(value, options)
  #   # options[:class] = [options[:class], 'input input-bordered w-full'].compact.join(' ')
  #   # debugger
  #   super(value, *options)
  # end

  # def check_box(name, options = {}, checked_value = "1", unchecked_value = "0")
  #   options[:class] = [options[:class], 'checkbox checkbox-primary'].join(' ')
  #   super(name, options, checked_value, unchecked_value)
  # end
  #
  # def radio_button(name, value, options = {})
  #   options[:class] = [options[:class], 'radio radio-primary'].join(' ')
  #   super(name, value, options)
  # end
end
