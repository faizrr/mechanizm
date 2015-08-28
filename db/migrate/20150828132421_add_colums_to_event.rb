class AddColumsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :user_id, :integer
    add_column :events, :title, :string
    add_column :events, :description, :text
    add_column :events, :start_datetime, :datetime
    add_column :events, :end_datetime, :datetime
  end
end
