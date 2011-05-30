class AdminConsoleController < ApplicationController

  USER_NAME, PASSWORD = "ryan", "ambush"

  before_filter :authenticate

  def index
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end

end
