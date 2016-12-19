class AddStudentIdColumnToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column(:playlists, :student_id, :integer)
  end
end
