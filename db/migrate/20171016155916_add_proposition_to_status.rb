class AddPropositionToStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :statuses, :proposition, :string
  end
end
