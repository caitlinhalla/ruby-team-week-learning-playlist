class AddTagToPlaylistCompleteColumn < ActiveRecord::Migration[5.0]
  def change
    add_column(:playlists, :tag, :string)
    add_column(:playlists, :complete, :boolean)
    add_column(:lessons, :complete, :boolean)
  end
end
