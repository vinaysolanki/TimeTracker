class TimeSheetsController < ApplicationController
  before_action :get_user
  before_action :get_time_sheet

  def show
    
  end

  def toggle_timer
    if timer_started?
      start_entry
    else
      stop_entry
    end
  end

  private

  def start_entry
    @time_sheet_entry = TimeSheetEntry.new(
      time_sheet: @time_sheet, 
      from: Time.now,
      to: "")
    if @time_sheet_entry.save
      render json: {}, status: :ok
    else
      render json: { error: "Unable to create save time sheet entry"}, status: 400
    end
  end

  def stop_entry
    @time_sheet_entry = @time_sheet.time_sheet_entries.last
    if @time_sheet_entry.update(to: Time.now)
      @time_sheet_entry.update_duration
      render 'stop_entry'
    else
      render json: { error: "Unable to save end time for time sheet entry" }, status: 400
    end
  end

  def get_time_sheet
    @time_sheet = TimeSheet.find(params[:id])
  end

  def get_user
    @user = User.find(params[:user_id])
  end

  def timer_started?
    if params[:time_sheet][:timer_state] == "1"
      return true
    else
      return false
    end
  end
end