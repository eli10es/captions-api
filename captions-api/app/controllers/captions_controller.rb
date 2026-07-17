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
        code: "missing_caption",
        title: "Caption not found",
        description: "Caption not found in the database",
      }, status: :not_found
    end
  end

  def create
    params.require(:caption).permit(:url, :text)
    result_url = Generator.new(Downloader.new,Captioner.new).generate(params[:caption][:text],params[:caption][:url])
    caption = Caption.new(url: params[:caption][:url], text: params[:caption][:text], caption_url: result_url)
    caption.save!
      render json: caption, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: {
        code: "invalid_attributes",
        title: "Unprocessable Entity",
        description: e.message
      }, status: :unprocessable_entity
  end

  def destroy
    caption = Caption.find_by(id: params[:id])
    caption.destroy!
      render status: :ok
    rescue ActiveRecord::ActiveRecordError => e
      render json: {
        code: "invalid_deletion",
        title: "Something happened",
        description: e.message
      }, status: :unprocessable_entity
  end

end
