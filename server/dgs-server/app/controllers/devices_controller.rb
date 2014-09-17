class DevicesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :ensure_authenticated_user
  def index
    @devices = Device.all.order("id").page(params[:page]).per_page(5)
    render json: @devices.to_json
  end

  def show
    @device = Device.find(params[:id])
    render json: @device.to_json
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      render json: @device
    else
      render json: {message: @device.errors.full_messages}
    end
  end

  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(device_params)
      render json: @device
    else
      render json: {message: @device.errors.full_messages}
    end
  end

  def destroy
    @device = Device.find(params[:id])
    if @device.destroy
      render json: @device
    else
      render json: {message: 'Something went wrong while deleting device'}
    end
  end

  private

  def device_params
    # params.require(:device).permit(:user_id, :location_id, :device_name, :space_available, :total_space_allocated, :status, :uptime)
    params.permit(:user_id, :location_id, :device_name, :space_available, :total_space_allocated, :status, :uptime)

  end
end
