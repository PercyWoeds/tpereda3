class Payroll < ActiveRecord::Base
    
    validates_presence_of :type_payroll_id, :parameter_id,:fecha,:fecha_inicial,:company_id,:user_id
    
    belongs_to :loan     
    belongs_to :parameter
    
    has_many :horas_mes
    has_many :type_payrolls
    has_many :payroll_details, :dependent => :destroy
    has_many :payrollbonis
    
    
     TABLE_HEADERS = ["ITEM",
                     "CANTIDAD",
                     "CODIGO",
                     "DESCRIPCION",
                     "PRECIO UNITARIO",
                     "DSCTO",
                     "VALOR TOTAL"]

      TABLE_HEADERS2 =["Nro.",
          "Fec.Ingreso",
          "DNI",
          "Empleado",
          "Area",
        "Puesto",
        "SSP/SNP",
        "Comision",
        "Sueldo Bruto",
        "Total Dia",
        "Faltas",
        "Vaca",
        "Des.Med.",
        "Subs.",
        "H.Extra",
        "Dias",
        "Sueldo Basico",
        "Asig.Familiar",
        "Horas Extras",
        "Vacac.",
        "Descanso Medico",
        "Subsidio",
        "Reintegro.",
        "Total.Ingreso",
        "Total Remun.",
        "ONP.",
        "Aporte",
        "Seguro",
        "Comision",
        "Renta.Quinta",
        "Faltas.",
        "Adelanto",
        "Otros ",
        "Total ",
        "Remun.Neta",
        "ESSALUD.",
        "Total.Aporte "]
      
      
   def process

      planilla  =Employee.where(planilla: "1")
      
      PayrollDetail.where(payroll_id: self.id).delete_all
      
      #Selecciona datos para calcular onp essalud
      
      lcOnp= 0
      lcSctr1 = 0
      lcSctr2 = 0
      lcEssalud = 0
      
      @detalle = Parameter.find(self.parameter_id)
      
      lcOnp = @detalle.onp
      lcSctr1 = @detalle.sctr_1
      lcSctr2 = @detalle.sctr_2
      lcEssalud = @detalle.essalud 
      lcAsignacion  = @detalle.asigfamiliar
      
      for ip in planilla
                
        #actualiza stock
        lccalc1= 0
        lccalc2= 0
        lccalc3= 0
        
        
      #Selecciona datos para calcular afp  
        lcafp=0
        lccalc4=0
        lccalc5=0
        lccalc6=0
        lccalc7=0
        
        lccalc8=0
        lccalc9=0
        lccalc10=0
        
        lctotal2=0
        lctotal3=0
        
        totalremu = ip.sueldo+lccalc1+lccalc2+lccalc3
        
        lcafp = ip.get_afp(@detalle.id)            
        
        
        if ip.onp == "1"
            lccalc5 = lcOnp/100 * totalremu
        else
            lccalc5 = 0
            lccalc6 = lcafp/100 * totalremu        
        end 
        
        
        lccalc8  = lcEssalud/100 * totalremu
        lccalc9  = lcSctr1/100 * totalremu
        lccalc10 = lcSctr2/100 * totalremu    
        lctotal3 = lccalc8+lccalc9+lccalc10
        #asignacion familiar 
        if ip.asignacion == 1
            lccalc1 = ip.asignacion * lcAsignacion
        end 
        lctotal2 = lccalc4 + lccalc5 + lccalc6 + lccalc7
        lcneto = totalremu -lctotal2
    
        #Actualizar Horas
        
        
        
        a=  PayrollDetail.new(employee_id: ip.id, remuneracion: ip.sueldo, calc1: lccalc1, calc2: 0, calc3: 0, total1: totalremu,
        calc4: 0, calc5: lccalc5.round(2), calc6: lccalc6.round(2), calc7: 0, total2: lctotal2, remneta: lcneto, calc8: lccalc8, calc9: lccalc9, calc10: lccalc10,
        total3: lctotal3,totaldia:30,falta:0,vaca:0,desmed:0,subsidio:0,hextra:0,reintegro:0,otros:0,dias:30, payroll_id: self.id,hextra0:0)
        
        a.save

        self.date_processed = Time.now
        self.save
      

      end
    end   
   
    def actualizar
        
         @horasplanilla = HorasMe.where(payroll_id: self.id)    
         
         for horas in @horasplanilla
                detalle = PayrollDetail.find_by(payroll_id: self.id,employee_id: horas.employee_id)
                if detalle 
                    detalle.falta = horas.fal
                    detalle.vaca = horas.vac
                    detalle.desmed = horas.dm
                    detalle.subsidio = horas.sub 
                    detalle.otros = horas.pat 
                    detalle.dias  = horas.tot 
                    detalle.totaldia = 30 - detalle.falta - detalle.vaca - detalle.desmed - detalle.subsidio - detalle.otros 
                    detalle.save 
                end 
         end 
         
        
        
        @planilla =  PayrollDetail.where(payroll_id: self.id)    
            
        for pl in @planilla
        
            pl.dias = pl.totaldia + pl.falta + pl.vaca 
            #Remuneracion neta
            
            pl.remneta = pl.remuneracion / 30 * (pl.totaldia ) 
            pl.hextra0 = 0
            pl.calc4 = 0 
            pl.calc7 = 0 
            pl.otros = 0
            pl.reintegro = 0
            
            pl.save 
        end
        
        #Asignacion familiar
        planilla  =Employee.where(planilla: "1" )
        
        @detalle = Parameter.find(self.parameter_id)
        
        lcAsignacion  = @detalle.asigfamiliar
        lcAporte  = @detalle.essalud
        lcValor = 0
        
        
        for ip in planilla
        
        if ip.asignacion != nil
            lcValor = lcAsignacion *ip.asignacion
        else
            lcValor = 0
        end 
        
        PayrollDetail.where(payroll_id: self.id,employee_id: ip.id).update_all(calc1: lcValor )
        lcValor = 0
        end 
        
        a = Payrollboni.where(payroll_id: self.id)
        
        for he in a 
            
            if he.valor_id == 4 
                detalle = PayrollDetail.find_by(payroll_id: self.id,employee_id: he.employee_id)
                if detalle 
                detalle.hextra00 = (detalle.remuneracion + detalle.calc1 )/ 30 / 8 * 1.25 * he.importe
                detalle.hextra = he.importe 
                
                f2 = detalle.hextra00 / 30 * detalle.totaldia 
                detalle.hextra0 = f2.round(2)
                detalle.save
                end 
            elsif he.valor_id == 1 
                
                detalle = PayrollDetail.find_by(payroll_id: self.id,employee_id: he.employee_id)
                if detalle 
                f2 = he.importe
                detalle.calc7 = f2.round(2)
                detalle.save
                end 
            elsif  he.valor_id == 3
                detalle = PayrollDetail.find_by(payroll_id: self.id,employee_id: he.employee_id)
                if detalle 
                f2 = he.importe
                detalle.reintegro = f2.round(2)
                detalle.save
                end 
            elsif    he.valor_id == 5
                detalle = PayrollDetail.find_by(payroll_id: self.id,employee_id: he.employee_id)
                if detalle 
                f2 = he.importe
                detalle.calc4 = f2.round(2)
                detalle.save
                end 
            else
                detalle = PayrollDetail.find_by(payroll_id: self.id,employee_id: he.employee_id)
                if detalle 
                f2 = he.importe
                detalle.otros = f2.round(2)
                detalle.save
                end 
            end     
        #qu
        end
        
        @planilla =  PayrollDetail.where(payroll_id: self.id)
            
        for pl in @planilla
            
            if pl.hextra00 == nil
                lcHextra0 = 0
            else
                lcHextra0 = pl.hextra00
            end 
            if pl.hextra0 == nil
                lcHextra1 = 0
            else
                lcHextra1 = pl.hextra0
            end 
            
        
            lcVaca  = (pl.remuneracion + pl.calc1 + lcHextra0)/30  *pl.vaca 
            pl.vacaciones = lcVaca.round(2)
            
            lcDesmedico = pl.remuneracion/30 * pl.desmed 
            pl.desmedico = lcDesmedico.round(2)
            
            lcSubsidio = pl.remuneracion/30 * pl.subsidio
            pl.subsidio0 = lcSubsidio.round(2)
            

            lcBasico = pl.remuneracion/30 * (pl.totaldia  )
            if lcBasico < 930
                lcBasico = 930 
            end 

            pl.basico =lcBasico.round(2)
            
            lctotingreso = pl.basico+pl.calc1+lcHextra1+pl.vacaciones+pl.desmedico+pl.reintegro+pl.subsidio0 
            pl.totingreso = lctotingreso.round(2)
            
            lcFaltas = pl.remuneracion/30 * pl.falta
            pl.faltas = lcFaltas.round(2)
            
            lcRemBruta = pl.totingreso - pl.faltas - pl.subsidio0
            pl.total1 = lcRemBruta.round(2)
            
            if pl.employee.onp == "1"
                lcOnpcalculo = (self.parameter.onp  * pl.total1) / 100
                pl.calc5 = lcOnpcalculo.round(2)
            else
                pl.calc5 = 0
            end 
            lcAporteAfp = pl.employee.get_afp(self.parameter_id,"aporte")
            
            if pl.total1 < 9707.03
             lcSeguroAfp = pl.employee.get_afp(self.parameter_id,"seguro")
            else
             lcSeguroAfp = 0   
            end 
            lcComisionAfp = pl.employee.get_afp(self.parameter_id,"comision")
            #Afp
            lcAporteAfp0 = (lcAporteAfp * pl.total1) / 100
            lcSeguroAfp0 = (lcSeguroAfp * pl.total1) / 100
            lcComisionAfp0= (lcComisionAfp * pl.total1) / 100
            pl.aporte0 = lcAporteAfp 
            pl.seguro0 = lcSeguroAfp 
            pl.comision0 = lcComisionAfp
            
            pl.aporte = lcAporteAfp0.round(2)
            pl.seguro = lcSeguroAfp0.round(2)
            pl.comision = lcComisionAfp0.round(2)
            
            #Quinta 
            mes_anio_quinto = self.code
            parts_quinto = mes_anio_quinto.split("-")
            mes_quinto  = parts_quinto[0]
            anio_quinto = parts_quinto[1]
            

            
            @quinta =  Quinto.find_by(employee_id: pl.employee_id,anio: anio_quinto,mes: mes_quinto)
            if @quinta != nil
                pl.calc4 = @quinta.retencion_mensual.round(2)
            else
                pl.calc4 = 0
            end
                
            
            pl.total2 = pl.calc4+pl.calc5 + pl.calc7+ pl.faltas + pl.otros+pl.aporte+pl.seguro+pl.comision
            pl.remneta = pl.totingreso - pl.total2 
                
            if pl.total1 > 930.00 
                lcValor = pl.total1 * (lcAporte/100 )
            else
                lcValor = 76.50
            end 
                    
            pl.calc8  = lcValor.round(2)
            pl.total3 = lcValor.round(2)
            pl.save
            
            end
            
            
        
        
        
    end
   
   
    
end
