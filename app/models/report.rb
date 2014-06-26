require 'csv'
class Report < ActiveRecord::Base
  has_many :items

  def self.consume_csv(file)
    rows = CSV.read(file.path)
    ids = rows.map{|row|row[0].to_i}
    
    report = Report.new({name:"clearance_#{Time.now.strftime('%m-%d-%y')}"})
    Item.sellable(ids).each do |item|
      report.items << item if item.update_attributes({status:'clearanced',price_sold:item.min_sold_price,sold_at:Time.now})
    end
    if report.items.size > 0
      report.save
      return "#{report.items.size} items clearanced."
    else
      return "No items to clearance"
    end 
  end
end
