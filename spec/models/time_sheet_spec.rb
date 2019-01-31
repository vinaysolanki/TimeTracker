require 'rails_helper'

RSpec.describe TimeSheet, type: :model do

  let(:user) { User.create(name: "Bob", email: "bob@gmail.com", password: 'abc123', password_confirmation: 'abc123') }
  subject { described_class.new(name: "Project Time Sheet", user: user) }

  describe "Validations" do
    it "is valid with valid attributs" do
      expect(subject).to be_valid
    end

    it "is not valid without name" do
      subject.name = ''
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:time_sheet_entries) }
  end

  describe "#start_new_entry" do
    it "should start a new time sheet entry" do
      subject.save
      expect{subject.start_new_entry}.to change{subject.time_sheet_entries.count}.from(0).to(1)
    end

    it "should create a time sheet entry with current time as From time" do
      subject.save
      subject.start_new_entry
      Time.zone = 'Pacific Time (US & Canada)'
      expect(subject.time_sheet_entries.last.start_time).to include(Time.now.strftime('%l:%M:%S'))
    end
  end
end
