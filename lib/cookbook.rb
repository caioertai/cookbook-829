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

  def find(index)
    @recipes[index]
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    update_csv
  end

  def mark_recipe(recipe_index)
    @recipes[recipe_index].mark_as_done!
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      binding.pry
      # TYPECASTING
      row[:rating] = row[:rating].to_i      # Integer
      row[:done] = row[:done] == "true" # boolean

      @recipes << Recipe.new(
        name: row[:name],
        description: row[:description],
        rating: row[:rating],
        done: row[:done],
        prep_time: row[:prep_time],
      )
    end
  end

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[name description rating done prep_time] #headers
      @recipes.each do |recipe|
        csv << [
          recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time
        ]
      end
    end
  end
end
