class BoardsController < ApplicationController
  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save
      redirect_to @board, notice: "Board was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  private

    def board_params
      params.require(:board).permit(:name, :description)
    end
end
