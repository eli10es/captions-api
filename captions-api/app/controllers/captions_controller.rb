class CaptionsController < ApplicationController
  def index
    captions = Caption.all
    render json: { captions: captions }
  end

  def show
    caption = Caption.find_by(id: params[:id])
    if caption
      render json: caption
    else
      render json: {
        code: "missing_parameters",
        title: "Parameter is missing from the request body",
        description: "url parameter is missing from the request body. It is a required parameter and the request cannot be processed without it"
      }, status: :not_found
    end
  end
end
