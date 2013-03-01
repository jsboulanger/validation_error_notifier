ValidationErrorNotifier::EmailNotifier.configure do |c|
  c.default_sender = "Notifer <notifier@example.com>"
  c.default_recipients = ["js@example.com"]
  c.default_subject_prefix = "[DUMMY]"
end
