class CreateTimeSheetEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :time_sheet_entries do |t|
      t.datetime :from
      t.datetime :to
      t.integer :time_sheet_id

      t.timestamps
    end
  end
end
