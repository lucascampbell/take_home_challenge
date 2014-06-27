require 'spec_helper'

describe Report do
  before(:each) do
    @item = Item.find(1)
    @item.update_attributes({price_sold:nil,sold_at:nil})
    @item.reload

    Report.destroy_all
  end
  
  it "should consume csv file and update item to clearanced" do
    @item.update_attributes(status:'sellable')
    @item.style.update_attributes(wholesale_price:200,retail_price:1000,type:'pants')

    expect(Report.count).to eq(0)
    expect(@item.status).to eq('sellable')

    file = File.new('test_csv.csv')
    Report.consume_csv(file)
    @item.reload

    price = Item::CLEARANCE_PRECENTAGE * @item.style.wholesale_price
    expect(@item.status).to eq('clearanced')
    expect(@item.price_sold).to eq(price)
    expect(Report.count).to eq(1)
  end

  it "should fail to update item if already sold" do
    res = @item.update_attributes(status:'sold')
    expect(@item.status).to eq('sold')
    expect(Report.count).to eq(0)

    file = File.new('test_csv.csv')
    Report.consume_csv(file)
    @item.reload

    expect(@item.status).to eq('sold')
    expect(@item.price_sold).to be_nil
    expect(Report.count).to eq(0)
  end
    
end