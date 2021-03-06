class GastosController < ApplicationController
  before_action :set_gasto, only: [:show, :edit, :update, :destroy]


  def import
      Gasto.import(params[:file])
       redirect_to root_url, notice: "Clientes importadas."
  end 
  # GET /gastos
  # GET /gastos.json
  def index
    @company =Company.find(1)
    @gastos = Gasto.order(:codigo).paginate(:page => params[:page])
    
        if params[:search]
          @gastos = Gasto.search(params[:search]).order('id DESC').paginate(:page => params[:page])
        else
          @gastos = Gasto.all.order('id DESC').paginate(:page => params[:page]) 
        end
  end
def list_gastos
    @company = Company.find(params[:company_id])
    @pagetitle = "#{@company.name} - Gastos"
    @filters_display = "block"
    
    
    if(@company.can_view(current_user))
         @gastos = Gasto.all.order('id DESC').paginate(:page => params[:page])
        if params[:search]
          @gastos = Gasto.search(params[:search]).order('id DESC').paginate(:page => params[:page])
        else
          @gastos = Gasto.all.order('id DESC').paginate(:page => params[:page]) 
        end
    
    else
      errPerms()
    end
  end
  


  # GET /gastos/1
  # GET /gastos/1.json
  def show
  end

  # GET /gastos/new
  def new
    @gasto = Gasto.new
  end

  # GET /gastos/1/edit
  def edit
  end

  # POST /gastos
  # POST /gastos.json
  def create
    @gasto = Gasto.new(gasto_params)
    @gasto.company_id = 1
      respond_to do |format|
      if @gasto.save
        format.html { redirect_to @gasto, notice: 'Gasto was successfully created.' }
        format.json { render :show, status: :created, location: @gasto }
      else
        format.html { render :new }
        format.json { render json: @gasto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gastos/1
  # PATCH/PUT /gastos/1.json
  def update
    @gasto.company_id = 1
    
    respond_to do |format|
      if @gasto.update(gasto_params)
        format.html { redirect_to @gasto, notice: 'Gasto was successfully updated.' }
        format.json { render :show, status: :ok, location: @gasto }
      else
        format.html { render :edit }
        format.json { render json: @gasto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gastos/1
  # DELETE /gastos/1.json
  def destroy
    @gasto.destroy
    respond_to do |format|
      format.html { redirect_to gastos_url, notice: 'Gasto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gasto
      @gasto = Gasto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gasto_params
      params.require(:gasto).permit( :code, :descrip, :cuenta,:company_id,:grupo,:codigo,:fullcuenta)
    end
end
