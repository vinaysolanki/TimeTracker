class TimeSheet < ApplicationRecord
  validates :name, presence: true

  has_many :time_sheet_entries, dependent: :destroy
  belongs_to :user

  def start_new_entry
    TimeSheetEntry.create(time_sheet: self, from: Time.now, to: "")
  end

  def stop_entry
    time_sheet_entry = time_sheet_entries.last
    time_sheet_entry.to = Time.now
    time_sheet_entry.duration = Time.at(time_sheet_entry.to - time_sheet_entry.from)
    time_sheet_entry.save
  end
end
