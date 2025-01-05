class ApplicationController < ActionController::Base
  include CableReady::Broadcaster
  layout -> { ApplicationLayout.new(user: Current.user, alert: alert, notice: notice) }

  # allow_browser versions: :modern

  before_action :set_current_request_details
  before_action :set_current_user
  before_action :authenticate

  private
    def authenticate
      unless Current.session
        redirect_to sign_in_path
      end
    end

    def ensure_professor
      if !Current.user.professor?
        redirect_to root_path
      end
    end

    def set_current_user
      if session_record = Session.eager_load(user: [:professor, :student, :selected_room]).find_by_id(cookies.signed[:session_token])
        Current.session = session_record
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end
end
