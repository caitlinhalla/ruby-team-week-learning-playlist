class CreatePlaylistsTags < ActiveRecord::Migration[5.0]
  def change
    create_table(:playlists_tags) do |t|
      t.column(:playlist_id, :integer)
      t.column(:tag_id, :integer)
    end
  end
end
