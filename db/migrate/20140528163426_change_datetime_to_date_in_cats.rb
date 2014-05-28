class ChangeDatetimeToDateInCats < ActiveRecord::Migration
  def change
    change_column :cats, :birth_date, :date
  end
end
