require 'rails_helper'

RSpec.describe TimeSheetEntry, type: :model do
  let(:user) { User.create(name: "Bob", email: "bob@gmail.com") }
  let(:time_sheet) { TimeSheet.create(name: "Project Time Sheet", user: user) }
  subject { described_class.new(from: DateTime.now, to: DateTime.now + 10.minutes, time_sheet: time_sheet) }

  describe "Validations" do
    it "it is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without valid from time" do
      subject.from = "invalid from time"
      expect(subject).to_not be_valid
    end

    it "is not valid without valid to time" do
      subject.to = "invalid to time"
      expect(subject).to_not be_valid
    end

    it "has to time after from time" do
      subject.to = DateTime.now - 1.hour
      expect(subject).to_not be_valid
    end
  end
end
