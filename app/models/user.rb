class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one :time_sheet, dependent: :destroy

  after_create :create_time_sheet


  private

  def create_time_sheet
    TimeSheet.create(name: "Project Time Sheet", user: self)
  end
end
