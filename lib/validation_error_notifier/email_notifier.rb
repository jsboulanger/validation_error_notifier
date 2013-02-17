require "action_mailer"

module ValidationErrorNotifier

  # Notifies of validation error by email.
  class EmailNotifier < ActionMailer::Base

    self.mailer_name = 'validation_error_notifier'
    self.append_view_path "#{File.dirname(__FILE__)}/views"

    class << self
      attr_writer :default_sender
      attr_writer :default_recipients
      attr_writer :default_subject_prefix

      def configure
        yield(self)
      end

      # Email message 'from'
      def default_sender
        @default_sender || []
      end

      # Email message recipients.
      def default_recipients
        @default_recipients || []
      end

      # Prefix to the email subject.
      def default_subject_prefix
        @default_subject_prefix || "[VALIDATION ERROR]"
      end

      def default_options
        { :sender => default_sender,
          :recipients => default_recipients,
          :subject_prefix => default_subject_prefix }
      end
    end

    # Triggers a notificaton
    def notify(env, records, options = {})
      validation_error_notification(env, records, options).deliver
    end

    private

    def validation_error_notification(env, records, options={})
      @env     = env
      @records = records
      @options = options.reverse_merge(self.class.default_options)
      @request = build_request(env)
      @params  = @request.filtered_parameters
      @controller_action = "#{@request.params[:controller]}##{@request.params[:action]}"

      mail(:to   => @options[:recipients],
        :from    => @options[:sender],
        :subject => compose_subject) do |format|

        format.text { render "email_notifier/validation_error_notification" }
        format.html { render "email_notifier/validation_error_notification" }
      end
    end

    def build_request(env)
      ActionDispatch::Request.new(env)
    end

    def compose_subject
      subject = "#{@options[:subject_prefix]}"
      subject << " #{@controller_action}"
      subject << " has validation errors"
    end
  end
end
