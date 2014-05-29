class CatRentalRequest < ActiveRecord::Base
  
  before_validation(on: :create) do
    self.status ||= "PENDING"
  end
  
  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
      message: "%{value} is not a valid status" }
  validate :request_has_no_conflict
  validate :start_date_before_end_date
  
  belongs_to :cat
  belongs_to :user
  
  def approve!
    CatRentalRequest.transaction do
      # Deny overlaps
      deny_these = overlapping_pending_requests
      deny_these.each do |request|
        request.deny!
      end
      # Save approval
      self.status = "APPROVED"
      self.save!
    end
  end
  
  def deny!
    self.status = "DENIED"
    self.save!
  end
  
  def overlapping_requests
    CatRentalRequest.where.not('start_date > ? OR end_date < ?', self.end_date, self.start_date)
  end
  
  def overlapping_pending_requests
    overlapping_requests.where('status = ? AND cat_id = ?', "PENDING", self.cat_id)
  end
  
  def overlapping_approved_requests
    overlapping_requests.where('status = ? AND cat_id = ?', "APPROVED", self.cat_id)
  end
  
  def request_has_no_conflict
    if !overlapping_approved_requests.empty?
      errors[:base] << "Request conflicts with a prior rental."
    end
  end
  
  def start_date_before_end_date
    errors[:base] << "Impossible date range." if self.start_date > self.end_date
  end
  
end
