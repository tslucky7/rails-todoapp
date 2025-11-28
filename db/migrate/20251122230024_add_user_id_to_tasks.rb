class AddUserIdToTasks < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :user
  end
end
