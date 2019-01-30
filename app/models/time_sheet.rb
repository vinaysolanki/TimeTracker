class TimeSheet < ApplicationRecord
  validates :name, presence: true

  has_many :time_sheet_entries
  belongs_to :user
end
