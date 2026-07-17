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

  describe "POST /captions" do
    it "creates a new caption" do
      allow(Generator).to receive_message_chain(:new, :generate).and_return("https://server/public/random_uuid.jpg")
      allow(Downloader).to receive_message_chain(:new, :download).and_return("https://tmp/images/random_uuid.jpg")
      post captions_path, params: { caption:{  url: "https://tmp/images/random_uuid.jpg", text: "random_text" }}
      expect(response).to have_http_status(:created)
    end

    it "returns an error when url is missing" do
      post captions_path, params: { text: "random_text" }
      expect(response).to have_http_status(:bad_request)
    end

    it "returns an error when text is missing" do
      post captions_path, params: { url: "https://example.com/random_image.jpg" }
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns unprocessable content when text is too long' do\
        allow(Generator).to receive_message_chain(:new, :generate).and_return("https://server/public/random_uuid.jpg")
        allow(Downloader).to receive_message_chain(:new, :download).and_return("https://tmp/images/random_uuid.jpg")
        post captions_path, params: { caption:{  url: "https://tmp/images/random_uuid.jpg", text: "random_text" * 200 }}
        expect(response).to have_http_status(:unprocessable_content)
    end

    it 'returns unprocessable content when text is empty' do
      allow(Generator).to receive_message_chain(:new, :generate).and_return("https://server/public/random_uuid.jpg")
      allow(Downloader).to receive_message_chain(:new, :download).and_return("https://tmp/images/random_uuid.jpg")
      post captions_path, params: { caption:{  url: "https://tmp/images/random_uuid.jpg", text: "" }}
      expect(response).to have_http_status(:unprocessable_content)
    end

    it 'returns unprocessable content when url is empty' do
      allow(Generator).to receive_message_chain(:new, :generate).and_return("https://server/public/random_uuid.jpg")
      allow(Downloader).to receive_message_chain(:new, :download).and_return("https://tmp/images/random_uuid.jpg")
      post captions_path, params: { caption:{  url: "", text: "random_text" }}
      expect(response).to have_http_status(:unprocessable_content)
    end

    it 'returns unprocessable content when url is invalid' do

    end
  end

  describe "DELETE /captions/:id" do
     it "deletes a caption with a specific ID" do
       caption = Caption.create!(url: "https://example.com/random_image.jpg", text: "random_text", caption_url: "https://server/public/random_uuid.jpg")
       delete caption_path(id: caption.id)
       expect(response).to have_http_status(:ok)
     end
  end
end
