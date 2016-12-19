class CreateStudentsLessonsPlaylistsTables < ActiveRecord::Migration[5.0]
  def change
    create_table(:students) do |t|
      t.column(:name, :string)
      t.column(:guardian_status, :boolean)
    end

    create_table(:lessons) do |t|
      t.column(:title, :string)
      t.column(:description, :text)
      t.column(:external_link, :string)
      t.column(:tag, :string)
      t.column(:private, :boolean)
    end

    create_table(:playlists) do |t|
      t.column(:name, :string)
      t.column(:private, :boolean)
      t.column(:due_date, :datetime)
    end
  end
end
