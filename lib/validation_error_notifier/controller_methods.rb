module ValidationErrorNotifier
  module ControllerMethods
    extend ActiveSupport::Concern

    module ClassMethods

      # Call in app controllers to check for validation errors on actions.
      def notify_validation_error(options = {})
        after_filter :check_for_validation_errors, options
      end

      def skip_notify_validation_error(options = {})
        skip_after_filter :check_for_validation_errors, options
      end

    end

    private

    def check_for_validation_errors
      if !ignore_validation_errors? && records_with_errors.present?
        env = request.env

        user = self.current_user rescue nil
        env = env.merge('current_user' => user) if user

        @_validation_error_notification = ValidationErrorNotifier.notifier.notify(env, records_with_errors)
      end
    end

    def records_with_errors
      @_records_with_errors ||= begin
        instance_values.map do |name, var|

          # Skip instance variables starting with an underscore.
          # Instance variables used internally by Rails.
          next if name =~ /^_/

          if var.is_a?(Array)
            var.select { |v| record_has_errors?(v) }
          else
            var if record_has_errors?(var)
          end
        end.flatten.compact
      end
    end

    def record_has_errors?(record)
      record.respond_to?(:errors) && record.errors.present?
    end

    def ignore_validation_errors?
      false
    end

  end
end

