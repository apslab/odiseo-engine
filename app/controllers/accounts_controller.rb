class AccountsController < ApplicationController


  before_filter :find_parent
  before_filter :find_account, :except => [:index, :new, :create]

  layout 'apslabs', :only => [:index, :print_movim]

  respond_to :html, :xml, :json

  # GET /accounts
  # GET /accounts.json
  # GET /accounts.xml
  def index
    @accounts = (@parent.nil?) ? current_company.accounts.roots : @parent.children
    flash[:notice] = t('flash.actions.index.notice') if @accounts.empty?

    respond_with(@accounts) do |format|
      format.json do
        converter = Proc.new do |item|
          parent, children = item
          {:text => view_context.draw_tree_item_for_account(parent),
           :children => children.map(&converter)}
        end

        render :json => current_company.accounts.arrange.map(&converter)
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
    @account = Account.new
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

    @account = Account.new(params[:account].update(:company_id => current_company.id))
    if @account.save
      flash[:notice] = t('flash.actions.create.notice', :resource_name => Account.model_name.human)
      #@account.move_to_child_of(@parent.id) unless @parent.nil?
    else
      flash[:error] = @account.errors.full_messages.join('<br />')
    end
    #respond_with(@account, :location => accounts_path)
    redirect_to(accounts_path)
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  # PUT /accounts/1.xml
  def update
    flash[:notice] = t('flash.actions.update.notice', :resource_name => Account.model_name.human) if @account.update_attributes(params[:account])
    respond_with(@account, :location => accounts_path)
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  # DELETE /accounts/1.xml
  def destroy
    begin
      flash[:notice] = t('flash.actions.destroy.notice', :resource_name => Account.model_name.human) if @account.destroy
    rescue Apslabs::Exceptions::HasDetails => e
      flash[:error] = e.message
      redirect_to(accounts_path)
    end

    respond_with(@account)
  end

  def print_movim
      @account_movim_list = @account.details

      respond_to do |format|
        format.html # .html.erb
        format.xml  { render :xml => @account_movim_list }
#        format.pdf { render :pdf => "cc_#{@cliente.id}",
#                         :template => 'clientes/cuentacorriente.html.erb',
#                         :show_as_html => params[:debug].present?,      # allow debuging based on url param
#                         :layout => 'pdf.html.erb',
#                         :footer => { :right => "Reporte generado el #{l DateTime.current}" }
#                   }
#      end
    end
  end


  protected

  def find_parent
    @parent = current_company.accounts.find(params[:account_id]) unless params[:account_id].blank?
  end

  def find_account
    @account = current_company.accounts.find(params[:id])
  end
end

