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

describe SharesController do

  # This should return the minimal set of attributes required to create a valid
  # Share. As you add validations to Share, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { campaign_id: 1 }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SharesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all shares as @shares" do
      share = Share.create! valid_attributes
      get :index, {}, valid_session
      assigns(:shares).to_a.should eq([share])
    end
  end

  describe "GET show" do
    it "assigns the requested share as @share" do
      share = Share.create! valid_attributes
      get :show, {:id => share.to_param}, valid_session
      assigns(:share).should eq(share)
    end
  end

  describe "GET new" do
    it "assigns a new share as @share" do
      get :new, {}, valid_session
      assigns(:share).should be_a_new(Share)
    end
  end

  describe "GET edit" do
    it "assigns the requested share as @share" do
      pending "not implemented"
      share = Share.create! valid_attributes
      get :edit, {:id => share.to_param}, valid_session
      assigns(:share).should eq(share)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Share" do
        expect {
          post :create, {:share => valid_attributes}, valid_session
        }.to change(Share, :count).by(1)
      end

      it "assigns a newly created share as @share" do
        post :create, {:share => valid_attributes}, valid_session
        assigns(:share).should be_a(Share)
        assigns(:share).should be_persisted
      end

      it "redirects to the created share" do
        post :create, {:share => valid_attributes}, valid_session
        response.should redirect_to(Share.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved share as @share" do
        # Trigger the behavior that occurs when invalid params are submitted
        Share.any_instance.stub(:save).and_return(false)
        post :create, {:share => { "campaign_id" => "invalid value" }}, valid_session
        assigns(:share).should be_a_new(Share)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Share.any_instance.stub(:save).and_return(false)
        post :create, {:share => { "campaign_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested share" do
        share = Share.create! valid_attributes
        # Assuming there are no other shares in the database, this
        # specifies that the Share created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Share.any_instance.should_receive(:update).with({ "campaign_id" => "MyString" })
        put :update, {:id => share.to_param, :share => { "campaign_id" => "MyString" }}, valid_session
      end

      it "assigns the requested share as @share" do
        share = Share.create! valid_attributes
        put :update, {:id => share.to_param, :share => valid_attributes}, valid_session
        assigns(:share).should eq(share)
      end

      it "redirects to the share" do
        share = Share.create! valid_attributes
        put :update, {:id => share.to_param, :share => valid_attributes}, valid_session
        response.should redirect_to(share)
      end
    end

    describe "with invalid params" do
      it "assigns the share as @share" do
        share = Share.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Share.any_instance.stub(:save).and_return(false)
        put :update, {:id => share.to_param, :share => { "campaign_id" => "invalid value" }}, valid_session
        assigns(:share).should eq(share)
      end

      it "re-renders the 'edit' template" do
        pending "not implemented"
        share = Share.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Share.any_instance.stub(:save).and_return(false)
        put :update, {:id => share.to_param, :share => { "campaign_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested share" do
      share = Share.create! valid_attributes
      expect {
        delete :destroy, {:id => share.to_param}, valid_session
      }.to change(Share, :count).by(-1)
    end

    it "redirects to the shares list" do
      share = Share.create! valid_attributes
      delete :destroy, {:id => share.to_param}, valid_session
      response.should redirect_to(shares_url)
    end
  end

end
