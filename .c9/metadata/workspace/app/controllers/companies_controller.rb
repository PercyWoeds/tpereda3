{"filter":false,"title":"companies_controller.rb","tooltip":"/app/controllers/companies_controller.rb","undoManager":{"mark":30,"position":30,"stack":[[{"start":{"row":134,"column":2},"end":{"row":142,"column":2},"action":"insert","lines":["def planilla ","    @company = Company.find(params[:id])","    set_company(@company)","    ","    @pagetitle = @company[:name]","    @locations = Location.where(company_id: @company.id)","  end ","  ","  "],"id":2}],[{"start":{"row":134,"column":13},"end":{"row":134,"column":14},"action":"remove","lines":["a"],"id":3}],[{"start":{"row":134,"column":12},"end":{"row":134,"column":13},"action":"remove","lines":["l"],"id":4}],[{"start":{"row":134,"column":11},"end":{"row":134,"column":12},"action":"remove","lines":["l"],"id":5}],[{"start":{"row":134,"column":10},"end":{"row":134,"column":11},"action":"remove","lines":["i"],"id":6}],[{"start":{"row":134,"column":9},"end":{"row":134,"column":10},"action":"remove","lines":["n"],"id":7}],[{"start":{"row":134,"column":8},"end":{"row":134,"column":9},"action":"remove","lines":["a"],"id":8}],[{"start":{"row":134,"column":7},"end":{"row":134,"column":8},"action":"remove","lines":["l"],"id":9}],[{"start":{"row":134,"column":6},"end":{"row":134,"column":7},"action":"remove","lines":["p"],"id":10}],[{"start":{"row":134,"column":6},"end":{"row":134,"column":7},"action":"insert","lines":["e"],"id":11}],[{"start":{"row":134,"column":7},"end":{"row":134,"column":8},"action":"insert","lines":["x"],"id":12}],[{"start":{"row":134,"column":8},"end":{"row":134,"column":9},"action":"insert","lines":["m"],"id":13}],[{"start":{"row":134,"column":9},"end":{"row":134,"column":10},"action":"insert","lines":["a"],"id":14}],[{"start":{"row":134,"column":10},"end":{"row":134,"column":11},"action":"insert","lines":["n"],"id":15}],[{"start":{"row":134,"column":11},"end":{"row":134,"column":12},"action":"insert","lines":["e"],"id":16}],[{"start":{"row":134,"column":12},"end":{"row":134,"column":13},"action":"insert","lines":["s"],"id":17}],[{"start":{"row":134,"column":12},"end":{"row":134,"column":13},"action":"remove","lines":["s"],"id":18}],[{"start":{"row":134,"column":11},"end":{"row":134,"column":12},"action":"remove","lines":["e"],"id":19}],[{"start":{"row":134,"column":10},"end":{"row":134,"column":11},"action":"remove","lines":["n"],"id":20}],[{"start":{"row":134,"column":9},"end":{"row":134,"column":10},"action":"remove","lines":["a"],"id":21}],[{"start":{"row":134,"column":8},"end":{"row":134,"column":9},"action":"remove","lines":["m"],"id":22}],[{"start":{"row":134,"column":8},"end":{"row":134,"column":9},"action":"insert","lines":["a"],"id":23}],[{"start":{"row":134,"column":9},"end":{"row":134,"column":10},"action":"insert","lines":["m"],"id":24}],[{"start":{"row":134,"column":10},"end":{"row":134,"column":11},"action":"insert","lines":["n"],"id":25}],[{"start":{"row":134,"column":11},"end":{"row":134,"column":12},"action":"insert","lines":["e"],"id":26}],[{"start":{"row":134,"column":11},"end":{"row":134,"column":12},"action":"remove","lines":["e"],"id":27}],[{"start":{"row":134,"column":10},"end":{"row":134,"column":11},"action":"remove","lines":["n"],"id":28}],[{"start":{"row":134,"column":10},"end":{"row":134,"column":11},"action":"insert","lines":["e"],"id":29}],[{"start":{"row":134,"column":11},"end":{"row":134,"column":12},"action":"insert","lines":["n"],"id":30}],[{"start":{"row":134,"column":12},"end":{"row":134,"column":13},"action":"insert","lines":["s"],"id":31}],[{"start":{"row":133,"column":6},"end":{"row":134,"column":0},"action":"insert","lines":["",""],"id":33},{"start":{"row":134,"column":0},"end":{"row":134,"column":2},"action":"insert","lines":["  "]}]]},"ace":{"folds":[],"scrolltop":1587,"scrollleft":0,"selection":{"start":{"row":134,"column":2},"end":{"row":134,"column":2},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":29,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1547312381333,"hash":"7d02b10f2bd5028dbe206c1d3c796d59b526a623"}