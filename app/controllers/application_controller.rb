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

  def log_activity(action, status, payload: {})
    actor = @current_user || @current_client

    Audited::Audit.create!(
      user: actor,
      action: action,
      comment: status,
      remote_address: request.remote_ip,
      username: actor&.try(:email) || actor&.try(:company_name),
      audited_changes: {
        status: status,
        payload: payload,
        user_agent: request.user_agent
      }.compact
    )
  rescue => e
    Rails.logger.error("Failed to write activity log: #{e.message}")
  end
end
