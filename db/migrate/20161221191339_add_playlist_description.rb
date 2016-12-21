class AddPlaylistDescription < ActiveRecord::Migration[5.0]
  def change
    add_column(:playlists, :description, :string)
  end
end
