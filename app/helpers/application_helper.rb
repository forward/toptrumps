module ApplicationHelper
  def example_card_content
    @example_card_content ||= File.read(Rails.root + 'public/card.html')
  end
end
