class CampgroundsController < ApplicationController
  def create
    render json: Campground.create!(campground_params)
  end

  def show
    render json: Campground.find(params[:id])
  end

  def update
    campground = Campground.find(params[:id])
    campground.update(campground_params)
    render json: campground
  end

  def destroy
    render json: Campground.destroy(params[:id])
  end

  def index
    sort_order = params[:sort].eql?('low to high') ? :asc : :desc
    render json: Campground.select(:id, :name, :created_at, :updated_at)
                           .distinct.joins(:campsites).all.order(price_usd: sort_order)
  end

  def available
    date_range = Date.parse(params[:start_date])..Date.parse(params[:end_date])
    render json: Campground.available(date_range.to_a)
  end

  private

  def campground_params
    params.require(:campground).permit(:name)
  end
end
