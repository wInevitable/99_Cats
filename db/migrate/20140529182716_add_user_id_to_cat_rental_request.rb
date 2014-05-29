class AddUserIdToCatRentalRequest < ActiveRecord::Migration
  def change
    add_reference :cat_rental_requests, :user, index: true, null: false
  end
end
