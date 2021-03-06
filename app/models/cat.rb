class Cat < ActiveRecord::Base
  
  AGES = (1..30).to_a
  
  COLORS = %w(Black White Orange Yellow Gray Brown Blue)
  
  SEX = %w(M F)
  
  validates :age, :birth_date, :color, :name, :sex, :user_id, :presence => true
  validates :age, numericality: { only_integer: true }
  validates :sex, inclusion: { in: %w(M F),
      message: "%{value} is not a valid sex" }
  validates :color, inclusion: { in: %w(Black White Orange Yellow Gray Brown Blue),
          message: "%{value} is not a valid color" }
  
  has_many :cat_rental_requests, dependent: :destroy
  belongs_to(
    :owner,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )
  
  def all_requests
    self.cat_rental_requests
    #CatRentalRequest.where('cat_id = ?', self.id)
  end
  
  def pending_requests
    all_requests.where(status: 'PENDING')
  end
  
  def accepted_requests
    all_requests.where(status: 'APPROVED')
  end
  
  def denied_requests
    all_requests.where(status: 'DENIED')
  end
end
