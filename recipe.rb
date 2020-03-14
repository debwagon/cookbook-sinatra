class Recipe
  attr_reader :name, :description, :time, :skill
  def initialize(name, description, time, skill)
    @name = name
    @description = description
    @time = time
    @skill = skill
  end
end
