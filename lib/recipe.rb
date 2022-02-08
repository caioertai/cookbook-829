class Recipe
  attr_reader :name, :description, :rating, :prep_time

  # New pattern for initializing models!!!
  # Use hashes of attributes instead of order dependant arguments
  def initialize(attributes = {})
    @name        = attributes[:name]
    @description = attributes[:description]
    @rating      = attributes[:rating] || 0
    @done        = attributes[:done] || false
    @prep_time   = attributes[:prep_time] || "prep time not given"
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
