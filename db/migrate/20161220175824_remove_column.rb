class RemoveColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column(:lessons, :tag)
    add_column(:lessons, :tag_id, :integer)
  end
end
