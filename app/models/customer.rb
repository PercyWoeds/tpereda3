class Customer < ActiveRecord::Base
  validates_presence_of :company_id, :name
  validates_uniqueness_of :ruc
  
  belongs_to :company
  
  belongs_to :quotation
  
  has_many :invoices
  has_many :manifests
  has_many :facturas
  has_many :deliveries
  has_many :tempfactura 
  
  
  has_many :addresses , :dependent => :destroy
  
  accepts_nested_attributes_for :addresses, :reject_if => lambda { |a| a[:address].blank? }, :allow_destroy => true


    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Customer.create! row.to_hash 
        end
    end     

    def self.import2(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Address.create! row.to_hash 
        end
      end      
    
    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
      csv << column_names
      all.each do |customer|
        csv << customer.attributes.values_at(*column_names)
      end
    end   
  end 
  
  def get_taxable
    if(self.taxable == "1")
      return "Taxable"
    else
      return "Not taxable"
    end
  end

  


end
