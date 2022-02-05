require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_path)
    @csv_path = csv_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_path) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end
