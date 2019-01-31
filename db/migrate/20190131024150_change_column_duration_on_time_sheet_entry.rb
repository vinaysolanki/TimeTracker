class ChangeColumnDurationOnTimeSheetEntry < ActiveRecord::Migration[5.2]
  def change
    remove_column :time_sheet_entries, :duration
    add_column :time_sheet_entries, :duration, :datetime
  end
end
