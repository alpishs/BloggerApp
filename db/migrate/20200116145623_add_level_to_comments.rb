class AddLevelToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :level, :integer
  end
end
