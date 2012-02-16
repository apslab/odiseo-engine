class ExercisesController < AuthorizedController

  before_filter :find_exercise, :except => [:index, :opened, :closed, :new, :create, :from_date]

  respond_to :html, :xml, :json

  # GET /exercises
  # GET /exercises.json
  # GET /exercises.xml
  def index
    @exercises = current_company.exercises.all
    flash[:notice] = t('flash.actions.index.notice') if @exercises.empty?
    respond_with(@exercises)
  end

  # GET /exercises/opened
  # GET /exercises/opened.json
  # GET /exercises/opened.xml
  def opened
    @exercises = current_company.exercises.opened
    flash[:notice] = t('flash.actions.index.notice') if @exercises.empty?
    respond_with(@exercises) do |format|
      format.html { render :action => :index }
    end
  end

  # GET /exercises/closed
  # GET /exercises/closed.json
  # GET /exercises/closed.xml
  def closed
    @exercises = current_company.exercises.closed
    flash[:notice] = t('flash.actions.index.notice') if @exercises.empty?
    respond_with(@exercises) do |format|
      format.html { render :action => :index }
    end
  end

  # GET /exercises/from_date
  def from_date
    @exercise = current_company.exercises.from_date_or_default(params[:d])
    @accounts = @exercise.accounts
    respond_with(@accounts) do |format|
      format.html do 
        render :inline => view_context.options_for_select([['-- seleccione una cuenta --', nil]]+ @accounts.leaves.map{|a|[[a.code, a.name].compact.join(' &raquo; ').html_safe, a.id]}) 
      end

      format.json do
        data = {
          :started_on => @exercise.started_on,
          :finished_on => @exercise.finished_on,
          :accounts => view_context.options_for_select([['-- seleccione una cuenta --', nil]]+ @accounts.leaves.map{|a|[[a.code, a.name].compact.join(' &raquo; ').html_safe, a.id]}) 
        }

        render :json => data
      end
    end
  end

  # GET /exercises/1
  # GET /exercises/1.json
  # GET /exercises/1.xml
  def show
    respond_with(@exercise)
  end

  # GET /exercises/new
  # GET /exercises/new.json
  # GET /exercises/new.xml
  def new
    @exercise = Exercise.setup
    respond_with(@exercise)
  end

  # GET /exercises/1/edit
  # GET /exercises/1/edit.json
  # GET /exercises/1/edit.xml
  def edit
    respond_with(@exercise)
  end

  # POST /exercises
  # POST /exercises.json
  # POST /exercises.xml
  def create
    @exercise = Exercise.new(params[:exercise].update(:company_id => current_company.id))
    #TODO agregar cuentas a un ejercicio nuevo. Seleccionar las cuentas del último ejercicio
    #@exercise.accounts = 
    
    flash[:notice] = t('flash.actions.create.notice', :resource_name => Exercise.model_name.human) if @exercise.save
    respond_with(@exercise, :location => exercises_path)
  end

  # PUT /exercises/1
  # PUT /exercises/1.json
  # PUT /exercises/1.xml
  def update
    flash[:notice] = t('flash.actions.update.notice', :resource_name => Exercise.model_name.human) if @exercise.update_attributes(params[:exercise])
    respond_with(@exercise, :location => exercises_path)
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  # DELETE /exercises/1.xml
  def destroy
    flash[:notice] = t('flash.actions.destroy.notice', :resource_name => Exercise.model_name.human) if @exercise.destroy
    rescue  Apslabs::Exceptions::IsOpen, Apslabs::Exceptions::HasEntries => e
      flash[:error] = e.message

    respond_with(@exercise)
  end

  protected

  def find_exercise
    @exercise = current_company.exercises.find(params[:id])
  end
end

