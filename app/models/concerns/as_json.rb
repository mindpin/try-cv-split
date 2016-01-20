module AsJson
  extend ActiveSupport::Concern

  class_methods do
    def define_as_json(method_name, options)
      define_method method_name do
        as_json options
      end
    end
  end
end
