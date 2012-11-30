require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Panel::BillingsController do

  # This should return the minimal set of attributes required to create a valid
  # Panel::Billing. As you add validations to Panel::Billing, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Panel::BillingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all panel_billings as @panel_billings" do
      billing = Panel::Billing.create! valid_attributes
      get :index, {}, valid_session
      assigns(:panel_billings).should eq([billing])
    end
  end

  describe "GET show" do
    it "assigns the requested billing as @billing" do
      billing = Panel::Billing.create! valid_attributes
      get :show, {:id => billing.to_param}, valid_session
      assigns(:billing).should eq(billing)
    end
  end

  describe "GET new" do
    it "assigns a new billing as @billing" do
      get :new, {}, valid_session
      assigns(:billing).should be_a_new(Panel::Billing)
    end
  end

  describe "GET edit" do
    it "assigns the requested billing as @billing" do
      billing = Panel::Billing.create! valid_attributes
      get :edit, {:id => billing.to_param}, valid_session
      assigns(:billing).should eq(billing)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Panel::Billing" do
        expect {
          post :create, {:billing => valid_attributes}, valid_session
        }.to change(Panel::Billing, :count).by(1)
      end

      it "assigns a newly created billing as @billing" do
        post :create, {:billing => valid_attributes}, valid_session
        assigns(:billing).should be_a(Panel::Billing)
        assigns(:billing).should be_persisted
      end

      it "redirects to the created billing" do
        post :create, {:billing => valid_attributes}, valid_session
        response.should redirect_to(Panel::Billing.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved billing as @billing" do
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Billing.any_instance.stub(:save).and_return(false)
        post :create, {:billing => {}}, valid_session
        assigns(:billing).should be_a_new(Panel::Billing)
      end

      it "re-renders the 'new' templates" do
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Billing.any_instance.stub(:save).and_return(false)
        post :create, {:billing => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested billing" do
        billing = Panel::Billing.create! valid_attributes
        # Assuming there are no other panel_billings in the database, this
        # specifies that the Panel::Billing created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Panel::Billing.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => billing.to_param, :billing => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested billing as @billing" do
        billing = Panel::Billing.create! valid_attributes
        put :update, {:id => billing.to_param, :billing => valid_attributes}, valid_session
        assigns(:billing).should eq(billing)
      end

      it "redirects to the billing" do
        billing = Panel::Billing.create! valid_attributes
        put :update, {:id => billing.to_param, :billing => valid_attributes}, valid_session
        response.should redirect_to(billing)
      end
    end

    describe "with invalid params" do
      it "assigns the billing as @billing" do
        billing = Panel::Billing.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Billing.any_instance.stub(:save).and_return(false)
        put :update, {:id => billing.to_param, :billing => {}}, valid_session
        assigns(:billing).should eq(billing)
      end

      it "re-renders the 'edit' templates" do
        billing = Panel::Billing.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Billing.any_instance.stub(:save).and_return(false)
        put :update, {:id => billing.to_param, :billing => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested billing" do
      billing = Panel::Billing.create! valid_attributes
      expect {
        delete :destroy, {:id => billing.to_param}, valid_session
      }.to change(Panel::Billing, :count).by(-1)
    end

    it "redirects to the panel_billings list" do
      billing = Panel::Billing.create! valid_attributes
      delete :destroy, {:id => billing.to_param}, valid_session
      response.should redirect_to(panel_billings_url)
    end
  end

end
