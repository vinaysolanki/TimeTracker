require 'rails_helper'

RSpec.describe TimeSheet, type: :model do
  subject {
    described_class.new(name: "Project Time Sheet")
  }

  describe "Validations" do
    it "is valid with valid attributs" do
      expect(subject).to be_valid
    end

    it "is not valid without name" do
      subject.name = ''
      expect(subject).to_not be_valid
    end
  end
end
