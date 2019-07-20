{"filter":false,"title":"deliveries_controller.rb","tooltip":"/app/controllers/deliveries_controller.rb","ace":{"folds":[],"scrolltop":1446,"scrollleft":0,"selection":{"start":{"row":107,"column":34},"end":{"row":107,"column":34},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":86,"state":"start","mode":"ace/mode/ruby"}},"hash":"5bb9ff2d9e252d7668be1c08e7b0c7c852b7d0d5","undoManager":{"mark":100,"position":100,"stack":[[{"start":{"row":101,"column":11},"end":{"row":101,"column":12},"action":"insert","lines":["S"],"id":43}],[{"start":{"row":101,"column":12},"end":{"row":101,"column":13},"action":"insert","lines":["e"],"id":44}],[{"start":{"row":101,"column":13},"end":{"row":101,"column":14},"action":"insert","lines":["r"],"id":45}],[{"start":{"row":101,"column":14},"end":{"row":101,"column":15},"action":"insert","lines":["v"],"id":46}],[{"start":{"row":101,"column":15},"end":{"row":101,"column":16},"action":"insert","lines":["i"],"id":47}],[{"start":{"row":101,"column":16},"end":{"row":101,"column":17},"action":"insert","lines":["c"],"id":48}],[{"start":{"row":101,"column":17},"end":{"row":101,"column":18},"action":"insert","lines":["e"],"id":49}],[{"start":{"row":101,"column":18},"end":{"row":101,"column":19},"action":"insert","lines":["o"],"id":50}],[{"start":{"row":101,"column":19},"end":{"row":101,"column":20},"action":"insert","lines":["r"],"id":51}],[{"start":{"row":101,"column":20},"end":{"row":101,"column":21},"action":"insert","lines":["d"],"id":52}],[{"start":{"row":101,"column":21},"end":{"row":101,"column":22},"action":"insert","lines":["e"],"id":53}],[{"start":{"row":101,"column":22},"end":{"row":101,"column":23},"action":"insert","lines":["s"],"id":54}],[{"start":{"row":101,"column":22},"end":{"row":101,"column":23},"action":"remove","lines":["s"],"id":55}],[{"start":{"row":101,"column":21},"end":{"row":101,"column":22},"action":"remove","lines":["e"],"id":56}],[{"start":{"row":101,"column":21},"end":{"row":101,"column":22},"action":"insert","lines":["r"],"id":57}],[{"start":{"row":101,"column":21},"end":{"row":101,"column":22},"action":"remove","lines":["r"],"id":58}],[{"start":{"row":101,"column":21},"end":{"row":101,"column":22},"action":"insert","lines":["e"],"id":59}],[{"start":{"row":101,"column":22},"end":{"row":101,"column":23},"action":"insert","lines":["r"],"id":60}],[{"start":{"row":100,"column":0},"end":{"row":101,"column":0},"action":"insert","lines":["",""],"id":61}],[{"start":{"row":100,"column":0},"end":{"row":101,"column":0},"action":"remove","lines":["",""],"id":62}],[{"start":{"row":101,"column":11},"end":{"row":101,"column":23},"action":"remove","lines":["Serviceorder"],"id":63},{"start":{"row":101,"column":11},"end":{"row":101,"column":25},"action":"insert","lines":["tranportorders"]}],[{"start":{"row":101,"column":24},"end":{"row":101,"column":25},"action":"remove","lines":["s"],"id":64}],[{"start":{"row":101,"column":11},"end":{"row":101,"column":12},"action":"remove","lines":["t"],"id":65}],[{"start":{"row":101,"column":11},"end":{"row":101,"column":12},"action":"insert","lines":["T"],"id":66}],[{"start":{"row":101,"column":28},"end":{"row":101,"column":29},"action":"remove","lines":[" "],"id":67}],[{"start":{"row":101,"column":28},"end":{"row":101,"column":29},"action":"insert","lines":["."],"id":68}],[{"start":{"row":101,"column":29},"end":{"row":101,"column":62},"action":"insert","lines":[".paginate(:page => params[:page])"],"id":69}],[{"start":{"row":101,"column":28},"end":{"row":101,"column":29},"action":"remove","lines":["."],"id":70}],[{"start":{"row":104,"column":2},"end":{"row":105,"column":0},"action":"insert","lines":["",""],"id":71},{"start":{"row":105,"column":0},"end":{"row":105,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":105,"column":2},"end":{"row":106,"column":0},"action":"insert","lines":["",""],"id":72},{"start":{"row":106,"column":0},"end":{"row":106,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":105,"column":2},"end":{"row":136,"column":6},"action":"insert","lines":["def newfactura  ","    @company = Company.find(1)","    @purchaseorder = Purchaseorder.find(params[:id])      ","    $lcPurchaseOrderId = @purchaseorder.id","    $lcProveedorId  = @purchaseorder.supplier_id","    $lcProveedorName =@purchaseorder.supplier.name ","    $lcFechaEmision = @purchaseorder.fecha1","    $lcFormaPagoId  = @purchaseorder.payment_id","    $lcFormaPago    = @purchaseorder.payment.descrip","    $lcFormaPagoDias =@purchaseorder.payment.day","    $lcMonedaId   = @purchaseorder.moneda_id","    $lcMoneda  = @purchaseorder.moneda.description","    $lcLocationId = @purchaseorder.location_id","    $lcDivisionId = @purchaseorder.division_id","    $lcTipoFacturaCompra = \"0\"","  ","","    @detalleitems =  @company.get_orden_detalle(@purchaseorder.id)","","    @purchase = Purchase.new ","","    ","    @locations = @company.get_locations()","    @divisions = @company.get_divisions()","","    @documents = @company.get_documents()    ","    @servicebuys  = @company.get_servicebuys()","    @monedas  = @company.get_monedas()","    @payments  = @company.get_payments()","    @suppliers = @company.get_suppliers()      ","","  end "],"id":73}],[{"start":{"row":136,"column":6},"end":{"row":137,"column":0},"action":"insert","lines":["",""],"id":74},{"start":{"row":137,"column":0},"end":{"row":137,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":105,"column":16},"end":{"row":105,"column":18},"action":"remove","lines":["  "],"id":75}],[{"start":{"row":105,"column":15},"end":{"row":105,"column":16},"action":"remove","lines":["a"],"id":76}],[{"start":{"row":105,"column":14},"end":{"row":105,"column":15},"action":"remove","lines":["r"],"id":77}],[{"start":{"row":105,"column":13},"end":{"row":105,"column":14},"action":"remove","lines":["u"],"id":78}],[{"start":{"row":105,"column":12},"end":{"row":105,"column":13},"action":"remove","lines":["t"],"id":79}],[{"start":{"row":105,"column":11},"end":{"row":105,"column":12},"action":"remove","lines":["c"],"id":80}],[{"start":{"row":105,"column":10},"end":{"row":105,"column":11},"action":"remove","lines":["a"],"id":81}],[{"start":{"row":105,"column":9},"end":{"row":105,"column":10},"action":"remove","lines":["f"],"id":82}],[{"start":{"row":105,"column":9},"end":{"row":105,"column":10},"action":"insert","lines":["g"],"id":83}],[{"start":{"row":105,"column":10},"end":{"row":105,"column":11},"action":"insert","lines":["u"],"id":84}],[{"start":{"row":105,"column":11},"end":{"row":105,"column":12},"action":"insert","lines":["i"],"id":85}],[{"start":{"row":105,"column":12},"end":{"row":105,"column":13},"action":"insert","lines":["a"],"id":86}],[{"start":{"row":107,"column":33},"end":{"row":107,"column":34},"action":"remove","lines":["r"],"id":87}],[{"start":{"row":107,"column":32},"end":{"row":107,"column":33},"action":"remove","lines":["e"],"id":88}],[{"start":{"row":107,"column":31},"end":{"row":107,"column":32},"action":"remove","lines":["d"],"id":89}],[{"start":{"row":107,"column":30},"end":{"row":107,"column":31},"action":"remove","lines":["r"],"id":90}],[{"start":{"row":107,"column":29},"end":{"row":107,"column":30},"action":"remove","lines":["o"],"id":91}],[{"start":{"row":107,"column":28},"end":{"row":107,"column":29},"action":"remove","lines":["e"],"id":92}],[{"start":{"row":107,"column":27},"end":{"row":107,"column":28},"action":"remove","lines":["s"],"id":93}],[{"start":{"row":107,"column":26},"end":{"row":107,"column":27},"action":"remove","lines":["a"],"id":94}],[{"start":{"row":107,"column":25},"end":{"row":107,"column":26},"action":"remove","lines":["h"],"id":95}],[{"start":{"row":107,"column":24},"end":{"row":107,"column":25},"action":"remove","lines":["c"],"id":96}],[{"start":{"row":107,"column":23},"end":{"row":107,"column":24},"action":"remove","lines":["r"],"id":97}],[{"start":{"row":107,"column":22},"end":{"row":107,"column":23},"action":"remove","lines":["u"],"id":98}],[{"start":{"row":107,"column":21},"end":{"row":107,"column":22},"action":"remove","lines":["P"],"id":99}],[{"start":{"row":107,"column":21},"end":{"row":107,"column":22},"action":"insert","lines":["T"],"id":100}],[{"start":{"row":116,"column":45},"end":{"row":116,"column":46},"action":"insert","lines":["a"],"id":101},{"start":{"row":116,"column":46},"end":{"row":116,"column":47},"action":"insert","lines":["r"]}],[{"start":{"row":116,"column":47},"end":{"row":116,"column":48},"action":"insert","lines":["n"],"id":102}],[{"start":{"row":116,"column":47},"end":{"row":116,"column":48},"action":"remove","lines":["n"],"id":103}],[{"start":{"row":116,"column":46},"end":{"row":116,"column":47},"action":"remove","lines":["r"],"id":104}],[{"start":{"row":116,"column":45},"end":{"row":116,"column":46},"action":"remove","lines":["a"],"id":105}],[{"start":{"row":107,"column":22},"end":{"row":107,"column":23},"action":"insert","lines":["r"],"id":106}],[{"start":{"row":107,"column":23},"end":{"row":107,"column":24},"action":"insert","lines":["a"],"id":107}],[{"start":{"row":107,"column":24},"end":{"row":107,"column":25},"action":"insert","lines":["s"],"id":108}],[{"start":{"row":107,"column":24},"end":{"row":107,"column":25},"action":"remove","lines":["s"],"id":109}],[{"start":{"row":107,"column":24},"end":{"row":107,"column":25},"action":"insert","lines":["a"],"id":110}],[{"start":{"row":107,"column":24},"end":{"row":107,"column":25},"action":"remove","lines":["a"],"id":111}],[{"start":{"row":107,"column":23},"end":{"row":107,"column":24},"action":"remove","lines":["a"],"id":112}],[{"start":{"row":107,"column":23},"end":{"row":107,"column":24},"action":"insert","lines":["a"],"id":113}],[{"start":{"row":107,"column":24},"end":{"row":107,"column":25},"action":"insert","lines":["n"],"id":114}],[{"start":{"row":107,"column":25},"end":{"row":107,"column":26},"action":"insert","lines":["s"],"id":115}],[{"start":{"row":107,"column":25},"end":{"row":107,"column":26},"action":"remove","lines":["s"],"id":116}],[{"start":{"row":107,"column":24},"end":{"row":107,"column":25},"action":"remove","lines":["n"],"id":117}],[{"start":{"row":107,"column":24},"end":{"row":107,"column":25},"action":"insert","lines":["n"],"id":118}],[{"start":{"row":107,"column":21},"end":{"row":107,"column":25},"action":"remove","lines":["Tran"],"id":119},{"start":{"row":107,"column":21},"end":{"row":107,"column":34},"action":"insert","lines":["Tranportorder"]}],[{"start":{"row":107,"column":52},"end":{"row":107,"column":58},"action":"remove","lines":["      "],"id":120},{"start":{"row":107,"column":52},"end":{"row":108,"column":0},"action":"insert","lines":["",""]},{"start":{"row":108,"column":0},"end":{"row":108,"column":4},"action":"insert","lines":["    "]}],[{"start":{"row":109,"column":4},"end":{"row":121,"column":2},"action":"remove","lines":["$lcPurchaseOrderId = @purchaseorder.id","    $lcProveedorId  = @purchaseorder.supplier_id","    $lcProveedorName =@purchaseorder.supplier.name ","    $lcFechaEmision = @purchaseorder.fecha1","    $lcFormaPagoId  = @purchaseorder.payment_id","    $lcFormaPago    = @purchaseorder.payment.descrip","    $lcFormaPagoDias =@purchaseorder.payment.day","    $lcMonedaId   = @purchaseorder.moneda_id","    $lcMoneda  = @purchaseorder.moneda.description","    $lcLocationId = @purchaseorder.location_id","    $lcDivisionId = @purchaseorder.division_id","    $lcTipoFacturaCompra = \"0\"","  "],"id":121}],[{"start":{"row":111,"column":3},"end":{"row":111,"column":66},"action":"remove","lines":[" @detalleitems =  @company.get_orden_detalle(@purchaseorder.id)"],"id":122}],[{"start":{"row":111,"column":2},"end":{"row":111,"column":3},"action":"remove","lines":[" "],"id":123}],[{"start":{"row":113,"column":23},"end":{"row":113,"column":24},"action":"remove","lines":["e"],"id":124}],[{"start":{"row":113,"column":22},"end":{"row":113,"column":23},"action":"remove","lines":["s"],"id":125}],[{"start":{"row":113,"column":21},"end":{"row":113,"column":22},"action":"remove","lines":["a"],"id":126}],[{"start":{"row":113,"column":20},"end":{"row":113,"column":21},"action":"remove","lines":["h"],"id":127}],[{"start":{"row":113,"column":19},"end":{"row":113,"column":20},"action":"remove","lines":["c"],"id":128}],[{"start":{"row":113,"column":18},"end":{"row":113,"column":19},"action":"remove","lines":["r"],"id":129}],[{"start":{"row":113,"column":17},"end":{"row":113,"column":18},"action":"remove","lines":["u"],"id":130}],[{"start":{"row":113,"column":16},"end":{"row":113,"column":17},"action":"remove","lines":["P"],"id":131}],[{"start":{"row":113,"column":16},"end":{"row":113,"column":17},"action":"insert","lines":["D"],"id":132}],[{"start":{"row":113,"column":17},"end":{"row":113,"column":18},"action":"insert","lines":["e"],"id":133}],[{"start":{"row":113,"column":18},"end":{"row":113,"column":19},"action":"insert","lines":["l"],"id":134}],[{"start":{"row":113,"column":19},"end":{"row":113,"column":20},"action":"insert","lines":["i"],"id":135}],[{"start":{"row":113,"column":20},"end":{"row":113,"column":21},"action":"insert","lines":["v"],"id":136}],[{"start":{"row":113,"column":21},"end":{"row":113,"column":22},"action":"insert","lines":["e"],"id":137}],[{"start":{"row":113,"column":22},"end":{"row":113,"column":23},"action":"insert","lines":["r"],"id":138}],[{"start":{"row":113,"column":16},"end":{"row":113,"column":23},"action":"remove","lines":["Deliver"],"id":139},{"start":{"row":113,"column":16},"end":{"row":113,"column":24},"action":"insert","lines":["Delivery"]}],[{"start":{"row":108,"column":4},"end":{"row":112,"column":0},"action":"remove","lines":["","    ","","  ",""],"id":140}],[{"start":{"row":108,"column":2},"end":{"row":108,"column":4},"action":"remove","lines":["  "],"id":141}],[{"start":{"row":108,"column":0},"end":{"row":108,"column":2},"action":"remove","lines":["  "],"id":142}],[{"start":{"row":107,"column":52},"end":{"row":108,"column":0},"action":"remove","lines":["",""],"id":143}]]},"timestamp":1546104193703}