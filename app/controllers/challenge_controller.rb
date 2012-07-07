class ChallengeController < ApplicationController
  def stage
    if params[:card_id].present?
      @card1 = Card.find(params[:card_id])
    else
      @card1 = Card.random
    end
    @card2 = Card.random(@card1.id)
  end
  
  def winner
    @card1 = Card.find(params[:card1])
    @card2 = Card.find(params[:card2])
    @skill = TrumpCard::SKILLS[rand(TrumpCard::SKILLS.length)-1]
    
    if @card1.trump_card.score(@skill) > @card2.trump_card.score(@skill)
      @winner = @card1
      @loser  = @card2
    else
      @winner = @card2
      @loser  = @card1
    end
    @winner.win!
  end
end