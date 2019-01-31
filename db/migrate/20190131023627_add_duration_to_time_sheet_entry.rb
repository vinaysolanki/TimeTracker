class AddDurationToTimeSheetEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :time_sheet_entries, :duration, :integer
  end
end
