require "open-uri"
require "nokogiri"
require "pry-byebug"

# IMPORT
# open the url with user query ingredient
url = "https://www.allrecipes.com/search/results/?search=pie"
page_string = open(url).read
# parse the page with Nokogiri
html_doc = Nokogiri::HTML(page_string)
# find on the nok doc the recipe info
recipe_cards = html_doc.search(".card__detailsContainer-left")
recipe_cards.each do |card|
  # get the name and description from each card
  name = card.at("h3").content.strip
  description = card.at(".card__summary").content.strip
end
# display info to the user

puts "End"
