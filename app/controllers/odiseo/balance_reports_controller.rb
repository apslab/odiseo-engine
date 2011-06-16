module Odiseo
  class BalanceReportsController < ApplicationController

    respond_to :html#, :xml, :json

    # GET /odiseo/reports/new
    # GET /odiseo/reports/new.json
    # GET /odiseo/reports/new.xml
    def new
      @balance_report = BalanceReport.new
      respond_to do |format|
        format.html # .html.erb
      end
    end

    # POST /odiseo/reports
    # POST /odiseo/reports.json
    # POST /odiseo/reports.xml
    def create
      @balance_report = BalanceReport.new(params[:odiseo_balance_report])
      @accounts = @balance_report.accounts.map do |account|
        account.name = current_company.accounts.leaves.detect{|leave| 1*leave.id == 1*account.name}.try(:name)
        account
      end

      flash.now[:notice] = t('flash.actions.index.notice') if @balance_report.valid? && @accounts.empty?
      respond_to do |format|
        format.html do
          render :new
        end
      end
    end

  end
end
