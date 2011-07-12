module Odiseo
  class ReportDatesController < ApplicationController

    respond_to :html#, :xml, :json


    # GET /odiseo/report_dates/new
    # GET /odiseo/reports_dates/new.json
    # GET /odiseo/reports_dates/new.xml
    def new
      @report_date = ReportDate.new
      respond_to do |format|
        format.html # .html.erb
      end
    end

    # POST /odiseo/reports_dates
    # POST /odiseo/reports_dates.json
    # POST /odiseo/reports_dates.xml
    def create
      @report_date = ReportDate.new(params[:odiseo_report_date])
      @details = @report_date.details.page(params[:page])
      flash.now[:notice] = t('flash.actions.index.notice') if @report_date.valid? && @details.empty?
      respond_to do |format|
        format.html do
          render :new
        end
      end
    end

  end
end

