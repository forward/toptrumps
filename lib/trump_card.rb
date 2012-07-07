require "nokogiri"

class TrumpCard
  attr_reader :errors

  MAX_TOTAL_SCORE = 100
  SKILLS = [
    'Strength',
    'Speed',
    'Agility',
    'Age',
    'Power',
  ]

  def initialize(html)
    @html = html
    @doc = Nokogiri::HTML(@html)
    @errors = []
  end

  def skills
    @skills ||= @doc.css('.skill').map {|e| e.text }
  end

  def score(skill)
    score_map[skill]
  end

  def name
    @name ||= get_text('#name')
  end

  def description
    @description ||= get_text('#description')
  end

  def author
    @author ||= get_text('#author')
  end

  def total_score
    @total_score ||= scores.reduce(&:+)
  end

  def valid?
    @errors = []
    check(:name, 'My Name')
    check(:author, 'Your Name')
    check(:description)
    check_required_skils
    check_max_score
    @errors.empty?
  end

  private

  def check_max_score
    @errors << "your total score is #{total_score} but the maximum allowed is #{MAX_TOTAL_SCORE}" if total_score > MAX_TOTAL_SCORE
  end

  def check_required_skils
    SKILLS.each do |skill|
      @errors << "you are missing the skill '#{skill}'" unless skills.include?(skill)
    end
  end

  def check(field, default=nil)
    val = send(field)
    return @errors << "couldn't find #{field}" unless val
    return @errors << "#{field} was empty" unless val.length > 0
    return @errors << "you need to change the #{field} to be different" if default && val == default
  end

  def scores
    @scores ||= @doc.css('.score').map {|e| e.text.to_i }
  end

  def score_map
    @score_map ||= Hash[skills.zip(scores)]
  end

  def get_text(selector)
    @doc.css(selector).map {|e| e.text }.first
  end
end

# card = TrumpCard.new(File.read('card.html'))
# p card.valid?
# p card.errors
# p card.name
# p card.description
# p card.author
# p card.skills
# p card.score('Speed')
