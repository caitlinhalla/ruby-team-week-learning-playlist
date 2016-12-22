class AddUserRelations < ActiveRecord::Migration[5.0]
  def change
    create_table(:lessons_users) do |t|
      t.column(:user_id, :integer)
      t.column(:lesson_id, :integer)
    end
    create_table(:playlists_users) do |t|
      t.column(:user_id, :integer)
      t.column(:playlist_id, :integer)
    end
  end
end
