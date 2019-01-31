class TimeSheetsController < ApplicationController
  before_action :get_time_sheet

  def start_entry
    @time_sheet_entry = TimeSheetEntry.new(
      time_sheet: @time_sheet, 
      from: params[:start_time],
      to: "")
    if @time_sheet_entry.save
      render json: {}, status: 201
    else
      render json: { error: "Unable to create save time sheet entry"}, status: 400
    end
  end

  def stop_entry
    @time_sheet_entry = @time_sheet.time_sheet_entries.last
    if @time_sheet_entry.update(to: params[:end_time])
      render json: {}, status: 200
    else
      render json: { error: "Unable to save end time for time sheet entry" }, status: 400
    end
  end

  private

  def get_time_sheet
    @time_sheet = TimeSheet.find(params[:id])
  end
end