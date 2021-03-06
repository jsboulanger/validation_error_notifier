require "spec_helper"

describe ValidationErrorNotifier::EmailNotifier do

  let(:environment) { {} }
  let(:options) { {} }
  let(:record) do
    mock_model("FooModel",
      :attributes => { :name => "Pablo", :email => nil },
      :errors => { :email => ["can't be blank"] })
  end
  let(:records) { [record] }
  let(:email) { ValidationErrorNotifier::EmailNotifier.notify(environment, records, options) }

  before do
    ValidationErrorNotifier::EmailNotifier.any_instance.stub(:build_request).and_return(stub('Request',
        :filtered_parameters => {},
        :params => {
          :controller => "FooController",
          :action => "create"
        }))
  end

  describe "#notify" do
    before do
      ValidationErrorNotifier::EmailNotifier.configure do |c|
        c.default_sender = "notifier@example.com"
        c.default_recipients = "recipient@example.com"
        c.default_subject_prefix = "SUBPREFIX"
      end
    end

    describe "the email" do

      subject { email }

      its(:from) { should == ["notifier@example.com"] }
      its(:to) { should == ["recipient@example.com"] }
      its(:subject) { should == "SUBPREFIX FooController#create has validation errors" }

    end

    describe "the email html body" do

      subject(:body) { email.html_part.body }

      it "shows a header for the invalid record" do
        body.should include("FooModel has 1 error")
      end

      it "does not show attributes without errors" do
        body.should_not include("name")
        body.should_not include("Pablo")
      end

      it "shows attributes with errors in bold" do
        body.should include("<li style=\"font-weight: bold; color: #b94a48\">email [&quot;can't be blank&quot;]</li>")
      end

    end

    describe "the email text body" do

      subject(:body) { email.text_part.body }

      it "shows a header for the invalid record" do
        body.should include("FooModel has 1 error")
      end

      it "doesn not show attributes without errors" do
        body.should_not include("name")
        body.should_not include("Pablo")
      end

      it "shows attributes with errors" do
        body.should include("*** email [&quot;can't be blank&quot;]")
      end

    end
  end
end
