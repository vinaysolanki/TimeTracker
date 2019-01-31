class TimeSheet < ApplicationRecord
  validates :name, presence: true

  has_many :time_sheet_entries, dependent: :destroy
  belongs_to :user
end
