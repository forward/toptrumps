class CardsController < InheritedResources::Base
  def index
    @cards = Card.order('win_count DESC').all
  end
  
  def iframe
    @card = Card.find(params[:id])
    render :text => @card.html
  end
end