class CaptionsController < ApplicationController
  def index
    captions = Caption.all
    render json: { captions: captions }
  end
end
