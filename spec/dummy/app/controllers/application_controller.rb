class ApplicationController < ActionController::Base
  protect_from_forgery
  notify_validation_error
end
