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

describe Panel::DealsController do

  # This should return the minimal set of attributes required to create a valid
  # Panel::Deal. As you add validations to Panel::Deal, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Panel::DealsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all panel_deals as @panel_deals" do
      deal = Panel::Deal.create! valid_attributes
      get :index, {}, valid_session
      assigns(:panel_deals).should eq([deal])
    end
  end

  describe "GET show" do
    it "assigns the requested deal as @deal" do
      deal = Panel::Deal.create! valid_attributes
      get :show, {:id => deal.to_param}, valid_session
      assigns(:deal).should eq(deal)
    end
  end

  describe "GET new" do
    it "assigns a new deal as @deal" do
      get :new, {}, valid_session
      assigns(:deal).should be_a_new(Panel::Deal)
    end
  end

  describe "GET edit" do
    it "assigns the requested deal as @deal" do
      deal = Panel::Deal.create! valid_attributes
      get :edit, {:id => deal.to_param}, valid_session
      assigns(:deal).should eq(deal)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Panel::Deal" do
        expect {
          post :create, {:deal => valid_attributes}, valid_session
        }.to change(Panel::Deal, :count).by(1)
      end

      it "assigns a newly created deal as @deal" do
        post :create, {:deal => valid_attributes}, valid_session
        assigns(:deal).should be_a(Panel::Deal)
        assigns(:deal).should be_persisted
      end

      it "redirects to the created deal" do
        post :create, {:deal => valid_attributes}, valid_session
        response.should redirect_to(Panel::Deal.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved deal as @deal" do
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Deal.any_instance.stub(:save).and_return(false)
        post :create, {:deal => {}}, valid_session
        assigns(:deal).should be_a_new(Panel::Deal)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Deal.any_instance.stub(:save).and_return(false)
        post :create, {:deal => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested deal" do
        deal = Panel::Deal.create! valid_attributes
        # Assuming there are no other panel_deals in the database, this
        # specifies that the Panel::Deal created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Panel::Deal.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => deal.to_param, :deal => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested deal as @deal" do
        deal = Panel::Deal.create! valid_attributes
        put :update, {:id => deal.to_param, :deal => valid_attributes}, valid_session
        assigns(:deal).should eq(deal)
      end

      it "redirects to the deal" do
        deal = Panel::Deal.create! valid_attributes
        put :update, {:id => deal.to_param, :deal => valid_attributes}, valid_session
        response.should redirect_to(deal)
      end
    end

    describe "with invalid params" do
      it "assigns the deal as @deal" do
        deal = Panel::Deal.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Deal.any_instance.stub(:save).and_return(false)
        put :update, {:id => deal.to_param, :deal => {}}, valid_session
        assigns(:deal).should eq(deal)
      end

      it "re-renders the 'edit' template" do
        deal = Panel::Deal.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Deal.any_instance.stub(:save).and_return(false)
        put :update, {:id => deal.to_param, :deal => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested deal" do
      deal = Panel::Deal.create! valid_attributes
      expect {
        delete :destroy, {:id => deal.to_param}, valid_session
      }.to change(Panel::Deal, :count).by(-1)
    end

    it "redirects to the panel_deals list" do
      deal = Panel::Deal.create! valid_attributes
      delete :destroy, {:id => deal.to_param}, valid_session
      response.should redirect_to(panel_deals_url)
    end
  end

end