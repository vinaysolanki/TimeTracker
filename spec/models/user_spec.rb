require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(name: 'Bob Proctor', email: 'bobproctor@gmail.com')
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without name" do
      subject.name = ''
      expect(subject).to_not be_valid
    end

      it "is not valid without email" do
      subject.email = ''
      expect(subject).to_not be_valid
    end

    it "is not valid without valid email" do
      subject.email = 'bobgmail.com'
      expect(subject).to_not be_valid
    end

    it "is not valid without unique email" do
      User.create(name: "Bobby Proctor", email: 'bobproctor@gmail.com')
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it { should have_one(:time_sheet) }

    it "should create a new time sheet when user is created" do
      subject.save
      expect(subject.time_sheet.name).to include("Time Sheet")
    end
  end
end
