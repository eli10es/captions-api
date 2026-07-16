require 'rails_helper'

RSpec.describe "Captions", type: :request do
  describe "GET /captions" do

    it "returns http success" do
      get captions_path
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["captions"]).to eq([])
    end

    it "returns captions" do
      caption = Caption.create!(url: "https://example.com/random_image.jpg", text: "random_text", caption_url: "https://server/public/random_uuid.jpg")
      get captions_path
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["captions"].length).to eq(1)
    end

    it 'returns a specific caption' do
      caption = Caption.create!(url: "https://example.com/random_image.jpg", text: "random_text", caption_url: "https://server/public/random_uuid.jpg")
      get caption_path(id: caption.id)
      expect(response).to have_http_status(:ok)
    end

    it 'returns 404 for a non-existent caption' do
      get caption_path(id: 67)
      expect(response).to have_http_status(:not_found)
    end

  end
end
