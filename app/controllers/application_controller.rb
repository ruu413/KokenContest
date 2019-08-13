class ApplicationController < ActionController::Base
    
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      #username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      username == "user" && password == "pass"
    end
  end
  def basic_auth_admin
    authenticate_or_request_with_http_basic do |username, password|
      #username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      username == "use" && password == "pas"
    end
  end
end
