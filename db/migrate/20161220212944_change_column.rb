class ChangeColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column(:lessons, :private)
    add_column(:lessons, :is_private, :boolean)
  end
end
