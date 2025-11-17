class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save
      redirect_to @board, notice: "Board was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def board_params
      params.require(:board).permit(:name, :description)
    end
end
