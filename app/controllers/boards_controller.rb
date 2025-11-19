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
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to @board, notice: "ボードを作成しました"
    else
      flash.now[:error] = "ボードを作成できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to @board, notice: "ボードを更新しました"
    else
      flash.now[:error] = "ボードを更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy!
    redirect_to root_path, status: :see_other, notice: "ボードを削除しました"
  end

  private

    def board_params
      params.require(:board).permit(:name, :description)
    end
end
