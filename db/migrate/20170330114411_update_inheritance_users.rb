class UpdateInheritanceUsers < ActiveRecord::Migration
  def change
    remove_column :users, :num_flashcards_played, :integer
    remove_column :users, :type, :string
    change_column_default :users, :role, nil
    rename_column :users, :role, :type
  end
end
