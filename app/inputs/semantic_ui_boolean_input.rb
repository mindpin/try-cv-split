class SemanticUiBooleanInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    template.content_tag 'div', class: 'ui checkbox' do
      build_check_box(unchecked_value, merged_input_options) + label(wrapper_options)
    end
  end

  def label_input(wrapper_options = nil)
    input(wrapper_options)
  end

  private

  # Build a checkbox tag using default unchecked value. This allows us to
  # reuse the method for nested boolean style, but with no unchecked value,
  # which won't generate the hidden checkbox. This is the default functionality
  # in Rails > 3.2.1, and is backported in SimpleForm AV helpers.
  def build_check_box(unchecked_value, options)
    @builder.check_box(attribute_name, options, checked_value, unchecked_value)
  end

  # Booleans are not required by default because in most of the cases
  # it makes no sense marking them as required. The only exception is
  # Terms of Use usually presented at most sites sign up screen.
  def required_by_default?
    false
  end

  def checked_value
    options.fetch(:checked_value, 'true')
  end

  def unchecked_value
    options.fetch(:unchecked_value, 'false')
  end
end
