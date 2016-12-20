class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table(:tags) do |t|
      t.column(:name, :string)

    end
  end
end
