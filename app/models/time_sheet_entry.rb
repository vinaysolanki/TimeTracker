class TimeSheetEntry < ApplicationRecord
  validates_datetime :from, presence: true
  validates_datetime :to, allow_blank: true, after: :from

  belongs_to :time_sheet

  def start_time
    from.strftime('%A, %d %b %Y %l:%M:%S %p')
  end

  def end_time
    to.strftime('%A, %d %b %Y %l:%M:%S %p')
  end

  def time_duration
    duration.utc.strftime("%H:%M:%S")
  end
end
