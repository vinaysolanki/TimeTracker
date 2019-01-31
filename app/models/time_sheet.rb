class TimeSheet < ApplicationRecord
  validates :name, presence: true

  has_many :time_sheet_entries, dependent: :destroy
  belongs_to :user

  def start_new_entry
    set_pst_timezone
    TimeSheetEntry.create(time_sheet: self, from: Time.zone.now, to: "")
  end

  def stop_entry
    set_pst_timezone
    time_sheet_entry = time_sheet_entries.last
    time_sheet_entry.to = Time.zone.now
    time_sheet_entry.duration = Time.at(time_sheet_entry.to - time_sheet_entry.from)
    time_sheet_entry.save
  end

  private

  def set_pst_timezone
    Time.zone = 'Pacific Time (US & Canada)'
  end
end
