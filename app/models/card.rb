class TrumpCardValidator < ActiveModel::Validator
  def validate(record)
    return true if record.trump_card.valid?
    record.trump_card.errors.each do |e|
      record.errors[:base] << e
    end
  end
end

class Card < ActiveRecord::Base
  attr_accessible :html, :url, :callback

  validates_presence_of :url, :html

  include ActiveModel::Validations
  validates_with TrumpCardValidator

  # before_create :scrape_thimble
  before_validation :scrape_thimble

  def to_s
    name
  end

  def name
    trump_card.name
  end

  def self.random(not_id = nil)
    if not_id
      Card.where('id is not ?', not_id).first(:offset => rand(Card.where('id is not ?', not_id).count))
    else
      Card.first(:offset => rand(Card.count))
    end
  end

  def scrape_thimble
    response = RestClient.get url
    self.html = response.body
  end

  def trump_card
    @trump_card ||= TrumpCard.new(html)
  end

  def win!
    increment!(:win_count)
  end
end
