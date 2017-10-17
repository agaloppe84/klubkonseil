class AddUserRefToStatus < ActiveRecord::Migration[5.0]
  def change
    add_reference :statuses, :user, foreign_key: true
  end
end
