

class CaptionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    captions = Caption.all
    render json: { captions: captions.map { |caption| caption_json(caption) } }
  end

  def show
    caption = Caption.find(params[:id])
    render json: { caption: caption_json(caption) }
  end

  def create
    parsed_data = CaptionRequestParser.new.parse(params.to_json)
    if parsed_data.key?("errors")
      return render json: parsed_data["errors"].first, status: :bad_request
    end

    result_url = Generator.new(Downloader.new, Captioner.new).generate(params[:caption][:text], params[:caption][:url])
    caption = Caption.new(url: params[:caption][:url], text: params[:caption][:text], caption_url: result_url)
    caption.save!
    render json: { caption: caption_json(caption) }, status: :created
  end

  def destroy
    caption = Caption.find(params[:id])
    file_name = File.basename(caption.caption_url)
    file_path = "./public/#{file_name}"
    File.delete(file_path) if File.exist?(file_path)
    caption.destroy!
    render status: :ok
  end


  private

  def render_error(code, title, description, status)
    render json: {
      code: code,
      title: title,
      description: description
    }, status: status
  end

  def render_not_found
    render_error("missing_caption", "Caption not found", "Caption not found in the database", :not_found)
  end

  def render_unprocessable_entity(exception)
    render_error("invalid_attributes", "Unprocessable Entity", exception.message, :unprocessable_entity)
  end

  def caption_json(caption)
    caption.as_json(only: [:id, :url, :text, :caption_url])
  end

end
