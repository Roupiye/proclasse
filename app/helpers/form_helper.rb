module FormHelper
  def form_control(form, field, type: :text_field, label: nil, args: nil, named_args: {}, &block)
    required = is_required?(form.object, field)
    label ||= t(field).to_s.humanize
    label_text = required ? "#{label} *" : label
    named_args[:required] = true if required
    errors = form.object.errors[field]

    div(class: 'form-control') do
      form.label(field, label_text, class: 'label') unless type.to_s == "hidden_field"
      if block_given?
        block = Proc.new do
          form.send(type, [field, *args], named_args)
        end
        yield(block)
      else
        form.send(type, [field, *args], named_args)
      end
      field_errors(errors) if errors.present?
    end
  end

  private

  def is_required?(object, field)
    return false unless object && object.class.respond_to?(:validators_on)

    object.class.validators_on(field).any? do |validator|
      validator.is_a?(ActiveModel::Validations::PresenceValidator)
    end
  end

  def field_errors(errors)
    div(class: 'text-red-500 text-sm mt-1') do
      plain(errors.to_sentence)
    end
  end
end
