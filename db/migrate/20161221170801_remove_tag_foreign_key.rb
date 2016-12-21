class RemoveTagForeignKey < ActiveRecord::Migration[5.0]
  def change
    remove_column(:tags, :lesson_id)
  end
end
