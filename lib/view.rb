class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      box = recipe.done? ? "[X]" : "[ ]"
      puts "#{box} #{index + 1}. #{recipe.name} [#{recipe.prep_time}] (#{'*' * recipe.rating}):\n       ---- #{recipe.description}"
    end
  end

  def ask_for(string)
    puts "What's the #{string}?"
    gets.chomp
  end

  def ask_for_index
    puts "What's the number?"
    gets.chomp.to_i - 1
  end
end
