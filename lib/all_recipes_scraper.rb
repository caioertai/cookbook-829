require "open-uri"
require "nokogiri"
require_relative "recipe"

class AllRecipesScraper
  def initialize(query)
    @query = query
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@query}"
    page_string = open(url).read
    # parse the page with Nokogiri
    html_doc = Nokogiri::HTML(page_string)
    # find on the nok doc the recipe info
    recipe_cards = html_doc.search(".card__detailsContainer-left")
    recipes = []
    recipe_cards.first(5).each do |card|
      # get the name and description from each card
      name = card.at("h3").content.strip
      description = card.at(".card__summary").content.strip
      recipes << Recipe.new(
        name: name,
        description: description
      )
    end
    recipes
  end
end
