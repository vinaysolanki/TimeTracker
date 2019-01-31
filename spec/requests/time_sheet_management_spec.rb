require 'rails_helper'

RSpec.describe "Time Sheet Management", type: :request do
  let(:user) { User.create(name: 'Bob', email: 'bob@gmail.com', password: 'abc123', password_confirmation:'abc123') }
  let(:time_sheet) { user.time_sheet }
  let(:start_time) { Time.zone.now }
  let(:time_sheet_entry) { user.time_sheet.time_sheet_entries.first }

  before do
    post user_session_url(user: { email: user.email, password: user.password })
  end

  it "should start a new Time Sheet Entry with current time as From time" do
    post toggle_timer_user_time_sheet_url(user_id: user.id, 
      id: time_sheet.id,
      time_sheet: { timer_state: "1" }
    )

    expect(response.status).to eql(200)
    expect(time_sheet_entry.start_time).to eq(start_time.strftime('%A, %d %b %Y %l:%M:%S %p'))
  end

  it "should stop the Time Sheet Entry with current time as To time" do
    post toggle_timer_user_time_sheet_url(user_id: user.id, 
      id: time_sheet.id,
      time_sheet: { timer_state: "1" }
    ) # create Time Sheet Entry

    post toggle_timer_user_time_sheet_url(user_id: user.id, 
      id: time_sheet.id,
      time_sheet: { timer_state: "0" }
    )

    expect(response.status).to eql(200)
    expect(time_sheet_entry.end_time).to eql(Time.now.utc.strftime('%A, %d %b %Y %l:%M:%S %p'))

  end

  it "should record duration of Time Sheet Entry" do
    post toggle_timer_user_time_sheet_url(user_id: user.id, 
      id: time_sheet.id,
      time_sheet: { timer_state: "1" }
    ) # create Time Sheet Entry

    time_sheet_entry.from = Time.now.utc - 10.minutes
    time_sheet_entry.save

    post toggle_timer_user_time_sheet_url(user_id: user.id, 
      id: time_sheet.id,
      time_sheet: { timer_state: "0" }
    )

    expect(response.status).to eql(200)
    expect(time_sheet_entry.reload.time_duration).to eql("00:10:00")
  end
end