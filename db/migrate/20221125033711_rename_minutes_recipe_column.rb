class RenameMinutesRecipeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :recipes, :minutes_to_completion, :minutes_to_complete
  end
end
