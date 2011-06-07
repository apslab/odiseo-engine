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

describe Odiseo::ReportsController do

  # This should return the minimal set of attributes required to create a valid
  # Odiseo::Report. As you add validations to Odiseo::Report, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all odiseo_reports as @odiseo_reports" do
      report = Odiseo::Report.create! valid_attributes
      get :index
      assigns(:odiseo_reports).should eq([report])
    end
  end

  describe "GET show" do
    it "assigns the requested odiseo_report as @odiseo_report" do
      report = Odiseo::Report.create! valid_attributes
      get :show, :id => report.id.to_s
      assigns(:odiseo_report).should eq(report)
    end
  end

  describe "GET new" do
    it "assigns a new odiseo_report as @odiseo_report" do
      get :new
      assigns(:odiseo_report).should be_a_new(Odiseo::Report)
    end
  end

  describe "GET edit" do
    it "assigns the requested odiseo_report as @odiseo_report" do
      report = Odiseo::Report.create! valid_attributes
      get :edit, :id => report.id.to_s
      assigns(:odiseo_report).should eq(report)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Odiseo::Report" do
        expect {
          post :create, :odiseo_report => valid_attributes
        }.to change(Odiseo::Report, :count).by(1)
      end

      it "assigns a newly created odiseo_report as @odiseo_report" do
        post :create, :odiseo_report => valid_attributes
        assigns(:odiseo_report).should be_a(Odiseo::Report)
        assigns(:odiseo_report).should be_persisted
      end

      it "redirects to the created odiseo_report" do
        post :create, :odiseo_report => valid_attributes
        response.should redirect_to(Odiseo::Report.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved odiseo_report as @odiseo_report" do
        # Trigger the behavior that occurs when invalid params are submitted
        Odiseo::Report.any_instance.stub(:save).and_return(false)
        post :create, :odiseo_report => {}
        assigns(:odiseo_report).should be_a_new(Odiseo::Report)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Odiseo::Report.any_instance.stub(:save).and_return(false)
        post :create, :odiseo_report => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested odiseo_report" do
        report = Odiseo::Report.create! valid_attributes
        # Assuming there are no other odiseo_reports in the database, this
        # specifies that the Odiseo::Report created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Odiseo::Report.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => report.id, :odiseo_report => {'these' => 'params'}
      end

      it "assigns the requested odiseo_report as @odiseo_report" do
        report = Odiseo::Report.create! valid_attributes
        put :update, :id => report.id, :odiseo_report => valid_attributes
        assigns(:odiseo_report).should eq(report)
      end

      it "redirects to the odiseo_report" do
        report = Odiseo::Report.create! valid_attributes
        put :update, :id => report.id, :odiseo_report => valid_attributes
        response.should redirect_to(report)
      end
    end

    describe "with invalid params" do
      it "assigns the odiseo_report as @odiseo_report" do
        report = Odiseo::Report.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Odiseo::Report.any_instance.stub(:save).and_return(false)
        put :update, :id => report.id.to_s, :odiseo_report => {}
        assigns(:odiseo_report).should eq(report)
      end

      it "re-renders the 'edit' template" do
        report = Odiseo::Report.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Odiseo::Report.any_instance.stub(:save).and_return(false)
        put :update, :id => report.id.to_s, :odiseo_report => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested odiseo_report" do
      report = Odiseo::Report.create! valid_attributes
      expect {
        delete :destroy, :id => report.id.to_s
      }.to change(Odiseo::Report, :count).by(-1)
    end

    it "redirects to the odiseo_reports list" do
      report = Odiseo::Report.create! valid_attributes
      delete :destroy, :id => report.id.to_s
      response.should redirect_to(odiseo_reports_url)
    end
  end

end
