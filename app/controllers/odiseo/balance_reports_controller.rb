module Odiseo
  class BalanceReportsController < ApplicationController

    respond_to :html#, :xml, :json

    # GET /odiseo/reports/new
    # GET /odiseo/reports/new.json
    # GET /odiseo/reports/new.xml
    def new
      @balance_report = BalanceReport.new(current_company)
      respond_to do |format|
        format.html # .html.erb
      end
    end

    # POST /odiseo/reports
    # POST /odiseo/reports.json
    # POST /odiseo/reports.xml
    def create
      @balance_report = BalanceReport.new(current_company, params[:odiseo_balance_report])
      @accounts = @balance_report.accounts.page(params[:page])

      flash.now[:notice] = t('flash.actions.index.notice') if @balance_report.valid? && @accounts.empty?
      respond_to do |format|
        format.html do
          render :new
        end
      end
    end

  end
end

