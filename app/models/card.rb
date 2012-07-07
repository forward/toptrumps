class TrumpCardValidator < ActiveModel::Validator
  def validate(record)
    return true if record.trump_card.valid?
    record.trump_card.errors.each do |e|
      record.errors[:base] << e
    end
  end
end


class Card < ActiveRecord::Base
  attr_accessible :html, :url

  validates_presence_of :url, :html

  include ActiveModel::Validations
  validates_with TrumpCardValidator

  before_create :scrape_thimble

  def scrape_thimble
    response = RestClient.get url
    self.html = response.body
  end

  def trump_card
    @trump_card ||= TrumpCard.new(html)
  end
end
