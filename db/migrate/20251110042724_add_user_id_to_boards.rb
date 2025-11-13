class AddUserIdToBoards < ActiveRecord::Migration[8.0]
  def change
    add_reference :boards, :user
  end
end
