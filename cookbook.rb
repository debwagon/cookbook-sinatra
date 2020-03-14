require_relative 'recipe'
require 'csv'
require 'pry-byebug'


class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv = csv_file_path
    # @csv = CSV.open(csv_file_path)
    CSV.foreach(csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes.push(recipe) # in memory
    # binding.pry
    # @csv << recipe

    CSV.open(@csv, 'wb') do |csv|
      # binding.pry
      @recipes.each do |element|
        csv << [element.name, element.description, element.time, element.skill]
      end
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)

    CSV.open(@csv, 'wb') do |csv|
      # binding.pry
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.time, recipe.skill]
      end
    end
  end
end
