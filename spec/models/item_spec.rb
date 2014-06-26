require 'spec_helper'

describe Item do
  
  before(:each) do
    @item = Item.find(1)
    @item.update_attributes({price_sold:nil,sold_at:nil})
    @item.reload
  end
  
  it "should no include sold status" do
    ids = Item.all.pluck(:id)
    expect(Item.sellable(ids).pluck(:status).include?('sold')).to equal(false)
  end

  it "should return clearance price for item" do 
    @item.style.update_attributes(wholesale_price:4,type:'pants')
    expect(@item.clearance_price).to eq(3)

    @item.style.update_attributes(wholesale_price:3.5,type:'pants')
    expect(@item.clearance_price).to eq(2.625)
  end

  it "should set price to clearance price" do
    @item.style.update_attributes(wholesale_price:4,type:'pants')
    @item.min_sold_price

    expect(@item.price_sold).to eq(5)

    @item.style.update_attributes(wholesale_price:4,type:'dresses')
    @item.min_sold_price

    expect(@item.price_sold).to eq(5)

    @item.style.update_attributes(wholesale_price:2,type:'shirt')
    @item.min_sold_price

    expect(@item.price_sold).to eq(2)
  end

  it "should set price to min if less than min" do 

  end
    
  end