require_relative "recipe"
require_relative "view"
require_relative "all_recipes_scraper"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view     = View.new
  end

  def list
    # Ask COOKBOOK for the recipes
    recipes = @cookbook.all
    # Ask VIEW to display them
    @view.display(recipes)
  end

  def create
    # Ask VIEW to ask USER for a name
    recipe_name = @view.ask_for("name")
    # Ask VIEW to ask USER for a description
    recipe_description = @view.ask_for("description")
    # Ask VIEW to ask USER for a rating
    recipe_rating = @view.ask_for("rating").to_i
    # Ask VIEW to ask USER for a prep_time
    recipe_prep_time = @view.ask_for("preparation time").to_i
    # Ask RECIPE to instantiate
    new_recipe = Recipe.new(
      name: recipe_name,
      description: recipe_description,
      rating: recipe_rating,
      prep_time: recipe_prep_time
    )
    # Ask COOKBOOK to persist it
    @cookbook.add_recipe(new_recipe)
  end

  def mark
    recipes = @cookbook.all
    @view.display(recipes)
    recipe_index = @view.ask_for_index
    @cookbook.mark_recipe(recipe_index)
  end

  def destroy
    # Ask COOKBOOK for the recipes
    recipes = @cookbook.all
    # Ask VIEW to display them
    @view.display(recipes)
    # Ask VIEW to ask USER for an index
    recipe_index = @view.ask_for_index
    # Ask COOKBOOK to remove the Recipe of the given index
    @cookbook.remove_recipe(recipe_index)
  end

  def import
    # open the url with user query ingredient
    query = @view.ask_for("ingredient")
    # Ask SCRAPER for recipes
    recipes = AllRecipesScraper.new(query).call
    # Ask VIEW to display the recipes
    @view.display(recipes)
    # Ask VIEW to ask user for a recipe index
    recipe_index = @view.ask_for_index
    recipe_to_import = recipes[recipe_index]
    # Ask COOKBOOK to store the instance
    @cookbook.add_recipe(recipe_to_import)
  end
end
