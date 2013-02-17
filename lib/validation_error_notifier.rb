require "validation_error_notifier/controller_methods"
require "validation_error_notifier/email_notifier"

if defined?(ActionController::Base)
  ActionController::Base.class_eval do
    include ValidationErrorNotifier::ControllerMethods
  end
end

module ValidationErrorNotifier

  class << self

    # The notifier is responsible to send the notifications.
    attr_writer :notifier

    # Returns the notifier
    def notifier
      @notifier ||= :email_notifier # Email notifier by default.
      "ValidationErrorNotifier::#{@notifier.to_s.classify}".constantize
    end

    # Configure the validation error notifier:
    #   ValidationErrorNotifer.configure do |config|
    #     config.notifier = :email_notifier
    #   end
    def configure
      yield(self)
    end

  end
end
