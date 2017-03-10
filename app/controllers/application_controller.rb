class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout "application"

  # include Authenticable
  # include Renderable

  include SessionsHelper
  # include RequestsHelper
  # include ItemsHelper
end
