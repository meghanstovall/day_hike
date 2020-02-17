class TrailsController < ApplicationController

  def show
    @trail = Trail.find(params[:trail_id])
  end
end
