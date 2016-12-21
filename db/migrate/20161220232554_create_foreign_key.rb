class CreateForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_column(:tags, :lesson_id, :integer)
  end
end
