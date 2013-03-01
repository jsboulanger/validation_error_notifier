require 'spec_helper'

describe PostsController do

  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { :name => "A post"}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, {:post => valid_attributes}, valid_session
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, {:post => valid_attributes}, valid_session
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end

      it "redirects to the created post" do
        post :create, {:post => valid_attributes}, valid_session
        response.should redirect_to(Post.last)
      end

      it "does not send a validation error notification" do
        ValidationErrorNotifier.notifier.should_not_receive(:notify)
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => {}}, valid_session
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:post => {}}, valid_session
        assigns(:post).should be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:post => {}}, valid_session
        response.should render_template("new")
      end

      it "sends a validation error notification" do
        ValidationErrorNotifier.notifier.should_receive(:notify).once.and_return double("Email", :deliver => true)
        post :create, {:post => {}}, valid_session
      end

      describe "the email notification" do

        before do
          post :create, {:post => { :secret => "MY_LITTLE_SECRET" } }, valid_session
        end

        subject(:email) { assigns(:_validation_error_notification) }

        its(:subject) { should == "[DUMMY] posts#create has validation errors" }
        its(:from) { should == ["notifier@example.com"] }
        its(:to) { should == ["js@example.com"] }

        it "does not contain sensitive parameters" do
          email.html_part.body.should_not include("MY_LITTLE_SECRET")
        end

      end
    end
  end
end
