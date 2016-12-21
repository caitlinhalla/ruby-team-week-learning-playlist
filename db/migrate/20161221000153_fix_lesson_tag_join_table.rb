class FixLessonTagJoinTable < ActiveRecord::Migration[5.0]
  def change
      create_table(:lessons_tags) do |t|
      t.column(:lesson_id, :integer)
      t.column(:tag_id, :integer)
    end
  end
end
