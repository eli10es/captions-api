class AddCaptionUrlColumnToCaptions < ActiveRecord::Migration[8.1]
  def change
    add_column :captions, :caption_url, :string
  end
end
