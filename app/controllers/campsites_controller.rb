class CampsitesController < ApplicationController
  def create
    render json: Campsite.create!(campsite_params)
  end

  def show
    render json: Campsite.find(params[:id])
  end

  def update
    campsite = Campsite.find(params[:id])
    campsite.update(campsite_params)
    render json: campsite
  end

  def destroy
    render json: Campsite.destroy(params[:id])
  end

  def index
    render json: Campsite.includes(campground: { campsites: :bookings }).all
  end

  private

  def campsite_params
    params.require(:campsite).permit(:name, :price_usd, :campground_id)
  end
end
