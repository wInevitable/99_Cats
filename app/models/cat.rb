class Cat < ActiveRecord::Base
  
  AGES = (1..30).to_a
  
  COLORS = %w(Black White Orange Yellow Gray Brown Blue)
  
  SEX = %w(M F)
  
  validates :age, :birth_date, :color, :name, :sex, :presence => true
  validates :age, numericality: { only_integer: true }
  validates :sex, inclusion: { in: %w(M F),
      message: "%{value} is not a valid sex" }
  validates :color, inclusion: { in: %w(Black White Orange Yellow Gray Brown Blue),
          message: "%{value} is not a valid color" }
  
  
end
