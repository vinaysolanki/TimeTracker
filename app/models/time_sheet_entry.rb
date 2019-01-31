class TimeSheetEntry < ApplicationRecord
  validates_datetime :from, presence: true
  validates_datetime :to, allow_blank: true, after: :from

  belongs_to :time_sheet

  def start_time
    from.strftime('%Y-%m-%d %I:%M:%S')
  end

  def end_time
    to.strftime('%Y-%m-%d %I:%M:%S')
  end
end
