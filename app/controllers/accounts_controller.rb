class AccountsController < AuthorizedController

  before_filter :find_current_exercise
  before_filter :find_parent
  before_filter :find_account, :except => [:index, :new, :create]

  layout 'apslabs', :only => [:index, :print_movim]

  respond_to :html, :xml, :json

  # GET /accounts
  # GET /accounts.json
  # GET /accounts.xml
  def index
    @accounts = (@parent.nil?) ? @current_exercise.accounts.roots : @parent.children
    flash[:notice] = t('flash.actions.index.notice') if @accounts.empty?

    respond_with(@accounts) do |format|

      format.html do

        #@graph_accounts_credits = current_company.accounts.roots.map do |account|
        #  [account.name, account.self_and_descendants.map{|a|a.details.balance.to_f}.sum]
        #end

      end

      format.json do
        converter = Proc.new do |item|
          parent, children = item
          {:text => view_context.draw_tree_item_for_account(parent),
           :children => children.map(&converter)}
        end

        render :json => @current_exercise.accounts.arrange.map(&converter)
      end

    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  # GET /accounts/1.xml
  def show
    respond_with(@account)
  end

  # GET /accounts/new
  # GET /accounts/new.json
  # GET /accounts/new.xml
  def new
    @account = @current_exercise.accounts.build
    respond_with(@account)
  end

  # GET /accounts/1/edit
  # GET /accounts/1/edit.json
  # GET /accounts/1/edit.xml
  def edit
    respond_with(@account)
  end

  # POST /accounts
  # POST /accounts.json
  # POST /accounts.xml
  def create
    params[:account].update(:parent_id => @parent.id) unless @parent.nil?

    @account = Account.new(params[:account].update(:exercise_id => @current_exercise.id))
    if @account.save
      flash[:notice] = t('flash.actions.create.notice', :resource_name => Account.model_name.human)
    else
      flash[:error] = @account.errors.full_messages.join('<br />')
    end

    redirect_to(exercise_accounts_path(@current_exercise))
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  # PUT /accounts/1.xml
  def update
    flash[:notice] = t('flash.actions.update.notice', :resource_name => Account.model_name.human) if @account.update_attributes(params[:account])
    respond_with(@account, :location => exercise_accounts_path(@current_exercise))
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  # DELETE /accounts/1.xml
  def destroy
    begin
      flash[:notice] = t('flash.actions.destroy.notice', :resource_name => Account.model_name.human) if @account.destroy
    rescue Apslabs::Exceptions::HasDetails => e
      flash[:error] = e.message
      redirect_to(exercise_accounts_path(@current_exercise))
    end

    respond_with(@account, :location => exercise_accounts_path(@current_exercise))
  end

  protected

  def find_current_exercise
    @current_exercise = current_company.exercises.find(params[:exercise_id]) || current_company.exercises.from(Date.today) || current_company.exercises.first
    return redirect_to new_exercise_path, :notice => 'Debe crear al menos un ejercicio' if @current_exercise.nil?
  end

  def find_parent
    @parent = @current_exercise.accounts.find(params[:account_id]) unless params[:account_id].blank?
  end

  def find_account
    @account = @current_exercise.accounts.find(params[:id])
  end

end

