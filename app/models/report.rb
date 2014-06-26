require 'csv'
class Report < ActiveRecord::Base
  has_many :items

  def self.consume_csv(file)
    rows = CSV.read(file.path)
    ids = rows.map{|row|row[0].to_i}
    
    report = Report.new({name:"clearance_#{Time.now.strftime('%m-%d-%y')}"})
    Item.clearanced(ids).each do |item|
      report.items << item if item.update_attributes({status:'clearanced',price_sold:item.min_sold_price,sold_at:Time.now})
    end
    report.save if report.items.size > 0
  end
end
