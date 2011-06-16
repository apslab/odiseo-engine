module Odiseo
  class GeneralBalanceReportsController < ApplicationController

    respond_to :html#, :xml, :json

    # GET /odiseo/reports/new
    # GET /odiseo/reports/new.json
    # GET /odiseo/reports/new.xml
    def new
      @general_balance_report = GeneralBalanceReport.new
      respond_to do |format|
        format.html # .html.erb
      end
    end

    # POST /odiseo/reports
    # POST /odiseo/reports.json
    # POST /odiseo/reports.xml
    def create
      @general_balance_report = GeneralBalanceReport.new(params[:odiseo_general_balance_report])
      @accounts = @general_balance_report.accounts
      flash.now[:notice] = t('flash.actions.index.notice') if @general_balance_report.valid? && @accounts.empty?
      respond_to do |format|
        format.html do
          render :new
        end
      end
    end

  end
end
