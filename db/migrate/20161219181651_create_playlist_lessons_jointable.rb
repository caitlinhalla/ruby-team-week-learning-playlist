class CreatePlaylistLessonsJointable < ActiveRecord::Migration[5.0]
  def change
    create_table(:lessons_playlists) do |t|
      t.column(:lesson_id, :integer)
      t.column(:playlist_id, :integer)
    end
  end
end
