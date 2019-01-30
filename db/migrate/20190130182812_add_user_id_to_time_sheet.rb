class AddUserIdToTimeSheet < ActiveRecord::Migration[5.2]
  def change
    add_column :time_sheets, :user_id, :integer
  end
end
