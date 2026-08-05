class ApplicationController < ActionController::API

  def render_error(status, code, message, details = {})
    render json: {
      error: {
        code: code,
        message: message,
        details: details
      }
    }, status: status
  end

  def render_success(data = {}, status: :ok)
    render json: data, status: status
  end
end
