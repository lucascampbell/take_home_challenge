class InventoryController < ApplicationController

  def show
    if params[:id]  == 'item'
      @items = Item.all
      render :show
    else 
      @styles = Style.all 
      render :show_style
    end
  end
  
end
