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

  def time_duration
    duration.utc.strftime("%H:%M:%S")
  end

  def update_duration
    self.duration = Time.at(to - from)
    save
  end
end
