class CatRentalRequest < ActiveRecord::Base
  
  before_validation(on: :create) do
    self.status ||= "PENDING"
  end
  
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
      message: "%{value} is not a valid status" }
  validate :request_has_no_conflict
  
  belongs_to :cat
  
  def approve!
    self.status = "APPROVED"
    self.save
  end
  
  def overlapping_requests
    CatRentalRequest.where.not('start_date > ? OR end_date < ?', self.end_date, self.start_date)
  end
  
  def overlapping_approved_requests
    overlapping_requests.where('status = ?',"APPROVED")
  end
  
  def request_has_no_conflict
    if !overlapping_approved_requests.empty?
      errors[:base] << "Request conflicts with a prior rental."
    end
  end
  
end
