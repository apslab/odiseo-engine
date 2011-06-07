class Odiseo::ReportsController < ApplicationController

  before_filter :find_account

  respond_to :html#, :xml, :json


  # GET /odiseo/reports/new
  # GET /odiseo/reports/new.json
  # GET /odiseo/reports/new.xml
  def new
    @report = Report.new(@account)
    respond_to do |format|
      format.html # .html.erb
    end
  end

  # POST /odiseo/reports
  # POST /odiseo/reports.json
  # POST /odiseo/reports.xml
  def create
    @report = Report.new(@account, params[:odiseo_report])
    @details = @report.details
    flash.clear
    flash[:notice] = t('flash.actions.index.notice') if @report.valid? && @details.empty?
    respond_to do |format|
      format.html do
        render :new
      end
    end
  end

  protected

  def find_account
    @account = current_company.accounts.find(params[:account_id])
  end
end

