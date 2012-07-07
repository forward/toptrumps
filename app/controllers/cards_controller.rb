class CardsController < InheritedResources::Base
  def iframe
    @card = Card.find(params[:id])
    render :text => @card.html
  end
  
  def scrape
    @card = Card.find(params[:id])
    @card.scrape_thimble
    if @card.save
      redirect_to @card
    else
      #fail
    end
  end
end