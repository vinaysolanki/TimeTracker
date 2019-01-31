class TimeSheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user
  before_action :get_time_sheet

  def show
  end

  def toggle_timer
    if timer_started?
      @time_sheet.start_new_entry
      render json: {}, status: :ok
    else
      @time_sheet.stop_entry
      @time_sheet_entry = @time_sheet.time_sheet_entries.last
      render 'toggle_timer.js'
    end
  end

  private

  def get_time_sheet
    @time_sheet = @user.time_sheet
  end

  def get_user
    @user = current_user
  end

  def timer_started?
    if params[:time_sheet][:timer_state] == "1"
      return true
    else
      return false
    end
  end
end