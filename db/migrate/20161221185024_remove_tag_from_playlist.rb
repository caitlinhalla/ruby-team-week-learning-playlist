class RemoveTagFromPlaylist < ActiveRecord::Migration[5.0]
  def change
    remove_column(:playlists, :tag)
  end
end
