# Validation Error Notifier

Validation error notifier helps you uncover user experience
issues in your Ruby on Rails forms. The gem detects and notifies
you when a form submission fails because of an invalid model.
Strict model validation keeps your data clean, but it introduces
friction in your forms. Keep your users happy by reducing that
friction.

The gem currently only supports email notifications. It works
for a small site, but doesn't scale.

## Installation

Add the gem to your project's Gemfile:

  gem 'validation_error_notifier'

Install the gem

  bundle install


## Configuration

Configure the email notifier in an initializer:

config/initializers/validation_error_notifier.rb

```ruby
ValidationErrorNotifier::EmailNotifier.configure do |c|
  c.default_sender = "notifier@example.com"
  c.default_recipients = "recipient@example.com"
  c.default_subject_prefix = "[MYAPP]"
end
```

Enable the validation error notifier using the
notify_validation_errors method in your controllers. You can
enable the notifier for all actions in all your controllers:

```ruby
class ApplicationController < ActionController::Base
  notify_validation_errors
end
```

The method accepts the same options as a Rails after filter,
you can constraint the actions for which the notifier is
enabled using :only and :except :

```ruby
class PostsController < ApplicationController
  notify_validation_errors :only => [:create]
end
```

## Notifiers ##

Only an email notifier has been implemented, but other notifiers
could easily be plugged in (eg, statsd). Pull requests
for new notifiers are welcome.

## Acknowledgements

Part of this gem was inspired by the Guardrail notifier.
If you want a proper commercial service to do this
check out their service: [Guardrail](http://guardrailapp.com/)

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.  (if you want to
  have your own version, that is fine but bump version in a commit by itself I
  can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


## License and Copyright

Copyright (c) 2013 Jean-Sebastien Boulanger.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
