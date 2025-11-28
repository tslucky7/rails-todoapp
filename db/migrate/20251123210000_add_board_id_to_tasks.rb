class AddBoardIdToTasks < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :board, null: false
  end
end
