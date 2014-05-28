class Cat < ActiveRecord::Base
  
  validates :age, :birth_date, :color, :name, :sex, :presence => true
  validates :age, numericality: { only_integer: true }
  validates :sex, inclusion: { in: %w(M F),
      message: "%{value} is not a valid sex" }
  validates :color, inclusion: { in: %w(Black White Orange Yellow Gray Tan Blue),
          message: "%{value} is not a valid color" }
  
  
end
