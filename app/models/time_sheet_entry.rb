class TimeSheetEntry < ApplicationRecord
  validates_datetime :from, presence: true
  validates_datetime :to, presence: true, after: :from

  belongs_to :time_sheet
end
