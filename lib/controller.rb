require_relative "view"

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
    # Ask RECIPE to instantiate
    new_recipe = Recipe.new(recipe_name, recipe_description)
    # Ask COOKBOOK to persist it
    @cookbook.add_recipe(new_recipe)
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
end
