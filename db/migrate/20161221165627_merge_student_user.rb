class MergeStudentUser < ActiveRecord::Migration[5.0]
  def change
    remove_column(:playlists, :student_id, :integer)
    add_column(:playlists, :user_id, :integer)
    remove_column(:lessons, :tag_id, :integer)
    drop_table(:students)
  end
end
