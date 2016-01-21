class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    # 为了简化持久化保存行为包装的一个方法
    def _do_save(model, options={})
      json_params = options[:json_params] || {}

      if model.save
        render json: model.good_as_json(json_params)
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
end
