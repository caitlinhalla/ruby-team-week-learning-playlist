class RenamePrivateColumnInPlaylists < ActiveRecord::Migration[5.0]
  def change
    remove_column(:playlists, :private, :boolean)
    add_column(:playlists, :is_private, :boolean)
  end
end
