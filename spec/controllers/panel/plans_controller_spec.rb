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

describe Panel::PlansController do

  # This should return the minimal set of attributes required to create a valid
  # Panel::Plan. As you add validations to Panel::Plan, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Panel::PlansController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all panel_plans as @panel_plans" do
      plan = Panel::Plan.create! valid_attributes
      get :index, {}, valid_session
      assigns(:panel_plans).should eq([plan])
    end
  end

  describe "GET show" do
    it "assigns the requested plan as @plan" do
      plan = Panel::Plan.create! valid_attributes
      get :show, {:id => plan.to_param}, valid_session
      assigns(:plan).should eq(plan)
    end
  end

  describe "GET new" do
    it "assigns a new plan as @plan" do
      get :new, {}, valid_session
      assigns(:plan).should be_a_new(Panel::Plan)
    end
  end

  describe "GET edit" do
    it "assigns the requested plan as @plan" do
      plan = Panel::Plan.create! valid_attributes
      get :edit, {:id => plan.to_param}, valid_session
      assigns(:plan).should eq(plan)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Panel::Plan" do
        expect {
          post :create, {:plan => valid_attributes}, valid_session
        }.to change(Panel::Plan, :count).by(1)
      end

      it "assigns a newly created plan as @plan" do
        post :create, {:plan => valid_attributes}, valid_session
        assigns(:plan).should be_a(Panel::Plan)
        assigns(:plan).should be_persisted
      end

      it "redirects to the created plan" do
        post :create, {:plan => valid_attributes}, valid_session
        response.should redirect_to(Panel::Plan.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved plan as @plan" do
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Plan.any_instance.stub(:save).and_return(false)
        post :create, {:plan => {}}, valid_session
        assigns(:plan).should be_a_new(Panel::Plan)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Plan.any_instance.stub(:save).and_return(false)
        post :create, {:plan => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested plan" do
        plan = Panel::Plan.create! valid_attributes
        # Assuming there are no other panel_plans in the database, this
        # specifies that the Panel::Plan created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Panel::Plan.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => plan.to_param, :plan => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested plan as @plan" do
        plan = Panel::Plan.create! valid_attributes
        put :update, {:id => plan.to_param, :plan => valid_attributes}, valid_session
        assigns(:plan).should eq(plan)
      end

      it "redirects to the plan" do
        plan = Panel::Plan.create! valid_attributes
        put :update, {:id => plan.to_param, :plan => valid_attributes}, valid_session
        response.should redirect_to(plan)
      end
    end

    describe "with invalid params" do
      it "assigns the plan as @plan" do
        plan = Panel::Plan.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Plan.any_instance.stub(:save).and_return(false)
        put :update, {:id => plan.to_param, :plan => {}}, valid_session
        assigns(:plan).should eq(plan)
      end

      it "re-renders the 'edit' template" do
        plan = Panel::Plan.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Panel::Plan.any_instance.stub(:save).and_return(false)
        put :update, {:id => plan.to_param, :plan => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested plan" do
      plan = Panel::Plan.create! valid_attributes
      expect {
        delete :destroy, {:id => plan.to_param}, valid_session
      }.to change(Panel::Plan, :count).by(-1)
    end

    it "redirects to the panel_plans list" do
      plan = Panel::Plan.create! valid_attributes
      delete :destroy, {:id => plan.to_param}, valid_session
      response.should redirect_to(panel_plans_url)
    end
  end

end
