require 'rails_helper'

RSpec.describe "Time Sheet Management", type: :request do
  let(:user) { User.create(name: 'Bob', email: 'bob@gmail.com') }
  let(:time_sheet) { TimeSheet.create(name: 'Project Time Sheet', user: user) }
  let(:start_time) { Time.zone.now }
  let(:end_time) { Time.zone.now + 10.minutes }

  it "should start a new Time Sheet Entry with current time as From time" do
    post start_entry_time_sheet_url(time_sheet, start_time: start_time)

    expect(response.status).to eql(201)
    expect(time_sheet.time_sheet_entries.first.start_time).to eq(start_time.strftime('%Y-%m-%d %I:%M:%S'))
  end

  it "should return an error if Time Sheet Entry cannot be created" do
    post start_entry_time_sheet_url(time_sheet)
    response_body = JSON.parse(response.body)

    expect(response.status).to eql(400)
    expect(response_body["error"]).to include("Unable to create")
  end

  it "should stop the Time Sheet Entry with current time as To time" do
    post start_entry_time_sheet_url(time_sheet, start_time: start_time) # create Time Sheet Entry

    post stop_entry_time_sheet_url(time_sheet, end_time: end_time)

    expect(response.status).to eql(200)
    expect(time_sheet.time_sheet_entries.first.end_time).to eql(end_time.strftime('%Y-%m-%d %I:%M:%S'))

  end
  
  it "should record duration of Time Sheet Entry"
end