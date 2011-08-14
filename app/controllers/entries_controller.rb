class EntriesController < AuthorizedController

  before_filter :find_entry, :except => [:index, :new, :create]

  respond_to :html, :xml, :json

  # GET /entries
  # GET /entries.json
  # GET /entries.xml
  def index
    unless params[:exercise_id].blank?
      @exercise = current_company.exercises.find(params[:exercise_id])
    else
      @exercise = current_company.exercises.first
    end

    return redirect_to new_exercise_path, :notice => 'Debe crear al menos un ejercicio' if @exercise.nil?
  
    @entries = @exercise.entries.page(params[:page])
    #@entries = Entry.where(:exercise_id => @exercise.id).page(params[:page])

    flash.now[:notice] = t('flash.actions.index.notice') if @entries.empty?

    respond_with(@entries)
  end

  # GET /entries/1
  # GET /entries/1.json
  # GET /entries/1.xml
  def show
    respond_with(@entry)
  end

  # GET /entries/new
  # GET /entries/new.json
  # GET /entries/new.xml
  def new
    @entry = Entry.new   #Entry.setup
    @entry.exercise_id = params[:exercise_id]
    @entry.exercise = Exercise.find(@entry.exercise_id)
    
    @entry.date_on = Date.today.between?(@entry.exercise.started_on,@entry.exercise.finished_on) ? Date.today : @entry.exercise.period[1]
     
    2.times{@entry.details.build}
    
    #logger.debug @entry.exercise
    flash[:notice] = @entry.exercise.description + ' desde ' + @entry.exercise.started_on.to_s + ' hasta ' + @entry.exercise.finished_on.to_s
    
    respond_with(@entry)
  end

  # GET /entries/1/edit
  # GET /entries/1/edit.json
  # GET /entries/1/edit.xml
  def edit
    respond_with(@entry)
  end

  # POST /entries
  # POST /entries.json
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])
    @entry.exercise = Exercise.find(params[:exercise_id])
    
    #logger.info 'estoy aca'
    
    flash[:notice] = t('flash.actions.create.notice', :resource_name => Entry.model_name.human) if @entry.save
    #respond_with(@entry, :location => entries_path)

    respond_with(@entry) # show
  end

  # PUT /entries/1
  # PUT /entries/1.json
  # PUT /entries/1.xml
  def update
    flash[:notice] = t('flash.actions.update.notice', :resource_name => Entry.model_name.human) if @entry.update_attributes(params[:entry])
    respond_with(@entry, :location => entries_path)
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  # DELETE /entries/1.xml
  def destroy
    flash[:notice] = t('flash.actions.destroy.notice', :resource_name => Entry.model_name.human) if @entry.destroy
    respond_with(@entry)
  end

  protected

  def find_entry
    @entry = Entry.where(:exercise_id => current_company.exercise_ids).find(params[:id])
  end
end

