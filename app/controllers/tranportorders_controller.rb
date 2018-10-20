class TranportordersController < ApplicationController
  before_action :set_tranportorder, only: [:show, :edit, :update, :destroy]

  # GET /tranportorders
  # GET /tranportorders.json
  def index

  @tranportorders = Tranportorder.all.order(:fecha1).paginate(:page => params[:page]) 


  if params[:search]
    @tranportorders = Tranportorder.search(params[:search]).order("fecha1 DESC").paginate(:page => params[:page]) 
  else
    @tranportorders = Tranportorder.all.order("fecha1 DESC").paginate(:page => params[:page])  
  end

    
  end

  # GET /tranportorders/1
  # GET /tranportorders/1.json
  def show
  end

  # GET /tranportorders/new
  def new
    @tranportorder = Tranportorder.new

    @customers = @tranportorder.get_customers()
    @puntos =    @tranportorder.get_puntos()
    @employees = @tranportorder.get_employees() 
    
    @trucks = Truck.all.order(:placa )
    @tranportorder[:code] = "#{generate_guid6()}"
    
    @locations = Location.all
    @divisions = Division.all 
    
     @some_time1  = Time.now
    @some_time2  = Time.now
  
  end

  # GET /tranportorders/1/edit
  def edit
     @customers = @tranportorder.get_customers()
     @puntos    = @tranportorder.get_puntos()
     
    
     @employees = @tranportorder.get_employees() 
     @trucks    = Truck.all 
     @locations = Location.all
     @divisions = Division.all 
     
      @tranportorder = Tranportorder.find(params[:id])
     
    
     puts @tranportorder.ubication_id
     puts @tranportorder[:ubication_id] 
    
  end

  # POST /tranportorders
  # POST /tranportorders.json
  def create
    @tranportorder = Tranportorder.new(tranportorder_params)
    @customers = @tranportorder.get_customers()
    @puntos = @tranportorder.get_puntos()
  @employees = @tranportorder.get_employees() 
    @trucks = Truck.all 
    @locations = Location.all
    @divisions = Division.all 

    @tranportorder[:user_id] = @current_user.id
    @tranportorder[:company_id] = 1
    @tranportorder[:processed] = "1"

    respond_to do |format|
      if @tranportorder.save
        
         @tranportorder.correlativo

        format.html { redirect_to @tranportorder, notice: 'Tranportorder was successfully created.' }
        format.json { render :show, status: :created, location: @tranportorder }
      else
        format.html { render :new }
        format.json { render json: @tranportorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tranportorders/1
  # PATCH/PUT /tranportorders/1.json
  def update
    respond_to do |format|
      if @tranportorder.update(tranportorder_params)
        format.html { redirect_to @tranportorder, notice: 'Tranportorder was successfully updated.' }
        format.json { render :show, status: :ok, location: @tranportorder }
      else
        format.html { render :edit }
        format.json { render json: @tranportorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tranportorders/1
  # DELETE /tranportorders/1.json
  def destroy
   respond_to do |format|
   a = Delivery.find_by(:tranportorder_id=> params[:id])
   if a 
        format.html { redirect_to tranportorders_url, notice: 'Orden tiene guias asignadas no se puede eliminar' }
        format.json { render json: a.errors, status: :unprocessable_entity }
   else 
      @tranportorder.destroy

      format.html { redirect_to tranportorders_url, notice: 'Tranportorder was successfully destroyed.' }
      format.json { head :no_content }
    end
   end 
  end


##-----------------------------------------------------------------------------------
## REPORTE DE GUIAS EMITIDAS
##-----------------------------------------------------------------------------------
  def build_pdf_header(pdf)
      pdf.font "Helvetica" , :size => 8
     $lcCli  =  @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

    max_rows = [client_data_headers.length, invoice_headers.length, 0].max
      rows = []
      (1..max_rows).each do |row|
        rows_index = row - 1
        rows[rows_index] = []
        rows[rows_index] += (client_data_headers.length >= row ? client_data_headers[rows_index] : ['',''])
        rows[rows_index] += (invoice_headers.length >= row ? invoice_headers[rows_index] : ['',''])
      end

      if rows.present?

        pdf.table(rows, {
          :position => :center,
          :cell_style => {:border_width => 0},
          :width => pdf.bounds.width
        }) do
          columns([0, 2]).font_style = :bold

        end

        pdf.move_down 10

      end


      pdf.move_down 25
      pdf 
  end   

  def build_pdf_body(pdf)
    
    pdf.text "Ordenes de Transporte Emitidas : Desde "+@fecha1.to_s + " Hasta: "+@fecha2.to_s, :size => 11 
    pdf.text ""
    pdf.font "Helvetica" , :size => 6

      headers = []
      table_content = []

      Tranportorder::TABLE_HEADERS.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end

      table_content << headers

      nroitem=1

       for  orden in @orden_transporte
  
            row = []
            row << nroitem.to_s
            row << orden.code
            if orden.employee != nil
              row << orden.employee.full_name
            else
              row << "*Empleado no registrado ** " 
            end
            row << orden.get_placa(orden.truck2_id) 
            row << orden.get_punto(orden.ubication_id) 
            row << orden.get_punto(orden.ubication2_id)
            row << orden.fecha1.strftime("%d/%m/%Y")  
            row << orden.fecha2.strftime("%d/%m/%Y")
            row << orden.get_processed

            table_content << row

            nroitem=nroitem + 1
        end

      result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width
                                        } do 
                                          columns([0]).align=:center
                                          columns([1]).align=:center 
                                          columns([2]).align=:left
                                          columns([3]).align=:left
                                          columns([4]).align=:left  
                                          columns([5]).align=:left 
                                          columns([6]).align=:left
                                          columns([7]).align=:left 
                                          columns([8]).align=:left
                                        end                                          
      pdf.move_down 10      
      pdf

    end


    def build_pdf_footer(pdf)

        pdf.text ""
        pdf.text "" 

        pdf.bounding_box([0, 20], :width => 535, :height => 40) do
        pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]

      end

      pdf
      
  end



  # Export serviceorder to PDF
  def rpt_ost1_pdf

    @company=Company.find(params[:company_id])      

    @fecha1 = params[:fecha1]
    @fecha2 = params[:fecha2]
    @tipo = params[:tiporeporte]
          
    @orden_transporte = @company.get_ordertransporte_day(@fecha1,@fecha2,@tipo)  
      
    Prawn::Document.generate("app/pdf_output/ost1.pdf") do |pdf|      
        pdf.font "Helvetica"
        pdf = build_pdf_header(pdf)
        pdf = build_pdf_body(pdf)
        build_pdf_footer(pdf)
        $lcFileName =  "app/pdf_output/ost1.pdf"      
        
    end     

    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName
    #send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
    send_file("app/pdf_output/ost1.pdf", :type => 'application/pdf', :disposition => 'inline')
  end
  
  
  
  

##-----------------------------------------------------------------------------------
## REPORTE 2
##-----------------------------------------------------------------------------------
  def build_pdf_header2(pdf)
      pdf.font "Helvetica" , :size => 8
     $lcCli  =  @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

    max_rows = [client_data_headers.length, invoice_headers.length, 0].max
      rows = []
      (1..max_rows).each do |row|
        rows_index = row - 1
        rows[rows_index] = []
        rows[rows_index] += (client_data_headers.length >= row ? client_data_headers[rows_index] : ['',''])
        rows[rows_index] += (invoice_headers.length >= row ? invoice_headers[rows_index] : ['',''])
      end

      if rows.present?

        pdf.table(rows, {
          :position => :center,
          :cell_style => {:border_width => 0},
          :width => pdf.bounds.width
        }) do
          columns([0, 2]).font_style = :bold

        end

        pdf.move_down 10

      end


      pdf.move_down 25
      pdf 
  end   

  def build_pdf_body2(pdf)
    
    pdf.text "Ordenes de Transporte Emitidas : Desde "+@fecha1.to_s + " Hasta: "+@fecha2.to_s, :size => 11 
    pdf.text ""
   pdf.font_families.update("Open Sans" => {
          :normal => "app/assets/fonts/OpenSans-Regular.ttf",
          :italic => "app/assets/fonts/OpenSans-Italic.ttf",
        })

        pdf.font "Open Sans",:size =>6

      headers = []
      table_content = []

      Tranportorder::TABLE_HEADERS2.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end

      table_content << headers

      nroitem=1

       for  orden in @orden_transporte
  
            row = []
            row << nroitem.to_s
            row << orden.code
            row << ""
            row << ""
            
            row << ""
            row << ""
            @ordenfecha1 = orden.fecha1.strftime("%d/%m/%Y")  
            @ordenfecha2 = orden.fecha2.strftime("%d/%m/%Y")
            row << ""
            row << "" 
            row << ""
            row << orden.get_placa(orden.truck2_id) 
            
            if orden.employee != nil
              row << orden.employee.full_name
            else
              row << "*Empleado no registrado ** " 
            end
            
            @destino =  orden.get_punto(orden.ubication_id) +"-" + orden.get_punto(orden.ubication2_id)
            row << @destino
            row << ""
            row << ""
            row << ""
            row << ""
            row << ""
            
            table_content << row

            nroitem=nroitem + 1
            
            @guias = orden.get_delivery(orden.id)
            
            for guias in @guias 
            
            
              row = []
              row << ""
              row << ""
              
              row << guias.fecha1.strftime("%d/%m/%Y")  
              b = business_days_between(orden.fecha1,guias.fecha1)
              
              row << b
              
              row << guias.code
              row << guias.fecha1.strftime("%d/%m/%Y")  
              row << @ordenfecha1
              row << @ordenfecha2
              @facturas= guias.get_factura_delivery(guias.id)
              if @facturas != ""
                
                row << guias.get_delivery_customer(guias.id)
              else
                
                row << ""
              end 
              row << ""
              row << ""
              
              if @facturas !=""
                row << ""
                row << @facturas.total 
                a=business_days_between(orden.fecha1,@facturas.fecha)
                row << a
                row << @facturas.code
                row << @facturas.fecha.strftime("%d/%m/%Y")    
                row << @facturas.get_dias_formapago.to_s 
              else
                row << ""
                row << ""
                row << ""
                row << ""
                row << ""
                row << ""
              end 
              
              
              
              table_content << row
            
              if @facturas != ""    
              @cancela = guias.get_factura_cancela(@facturas.id)
              
              for cancela in  @cancela
              @fecha_cobranza = cancela.get_fecha_cobranza(cancela.customer_payment_id)
              
              if @fecha_cobranza
              row = []
              row << ""
              row << ""
              row << ""
              row << ""
              row << ""
              row << ""
              row << ""
              row << ""
              
              row << ""
              row << ""
              row << ""
              row << ""
              row << ""
              row << ""
              
              row << cancela.total 
              row << "CANCELA"
              
              row << @fecha_cobranza.fecha1.strftime("%d/%m/%Y")  
              
              table_content << row
              
              end 
              end 
                
              
              
              end 
              
              
            
            
            end 
            
            
            
            
        end

      result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width
                                        } do 
                                          columns([0]).align=:center
                                          columns([1]).align=:center 
                                          columns([2]).align=:left
                                          columns([3]).align=:left
                                          columns([4]).align=:left  
                                          columns([5]).align=:left 
                                          columns([6]).align=:left
                                          columns([7]).align=:left 
                                          columns([8]).align=:left
                                        end                                          
      pdf.move_down 10      
      pdf

    end


    def build_pdf_footer2(pdf)

        pdf.text ""
        pdf.text "" 

        pdf.bounding_box([0, 20], :width => 535, :height => 40) do
        pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]

      end

      pdf
      
  end



  # Export serviceorder to PDF
  def rpt_ost2_pdf

    @company=Company.find(params[:company_id])      

    @fecha1 = params[:fecha1]
    @fecha2 = params[:fecha2]
    @tipo   = params[:tiporeporte]
    @tipo = 1      
    @orden_transporte = @company.get_ordertransporte_day(@fecha1,@fecha2,@tipo)  
      
    Prawn::Document.generate "app/pdf_output/ost2.pdf" , :page_layout => :landscape do |pdf|      
        pdf.font "Helvetica"
        pdf = build_pdf_header2(pdf)
        pdf = build_pdf_body2(pdf)
        build_pdf_footer2(pdf)
        $lcFileName =  "app/pdf_output/ost2.pdf"      
        
    end     

    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName
    #send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
    send_file("app/pdf_output/ost2.pdf", :type => 'application/pdf', :disposition => 'inline')
  end
  
  def business_days_between(date1, date2)
  business_days = 0
  date = date2
  while date > date1
   business_days = business_days + 1 
   date = date.to_date  - 1.day
  end
  business_days
end
  
def client_data_headers

    #{@serviceorder.description}
      client_headers  = [["Empresa  :", $lcCli ]]
      client_headers << ["Direccion :", $lcdir1]
      client_headers
  end

  def invoice_headers            
      invoice_headers  = [["Fecha : ",$lcHora]]
    
      invoice_headers
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tranportorder
      @tranportorder = Tranportorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tranportorder_params
      params.require(:tranportorder).permit(:code, :employee_id, :truck_id, :employee2_id, :truck2_id, :ubication_id, :ubication2_id, :fecha1, :fecha2, :description, :comments, :processed, :company_id, :location_id, :division_id)
    end
end
