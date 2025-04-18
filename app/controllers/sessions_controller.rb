class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[ new create ]

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def change_context
    Current.user.toggle_context

    redirect_back fallback_location: root_path
  end

  def new
    @session = Session.new
  end

  def create
    if user = User.authenticate_by(email: params[:session][:email], password: params[:session][:password])
      @session = user.sessions.create!
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

      if session[:request_entry]
        redirect_to room_request_path(session[:request_entry])
      else
        redirect_to root_path, notice: "Signed in successfully"
      end
    else
      redirect_to sign_in_path(email_hint: params[:session][:email]), alert: "That email or password is incorrect"
    end
  end

  def destroy
    @session.destroy; redirect_to(sessions_path, notice: "That session has been logged out")
  end

  private
    def set_session
      @session = Current.user.sessions.find(params[:id])
    end
end
