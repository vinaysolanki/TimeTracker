require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(name: 'Bob Proctor', email: 'bobproctor@gmail.com')
  }

  it "should have a valid name" do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it "should have a valid email" do
    subject.email = 'bobgmail.com'
    expect(subject).to_not be_valid
  end
end
