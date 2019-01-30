require 'rails_helper'

RSpec.describe TimeSheet, type: :model do

  let(:user) { User.create(name: "Bob", email: "bob@gmail.com") }
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
end
