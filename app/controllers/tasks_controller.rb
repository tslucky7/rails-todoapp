class TasksController < ApplicationController
  before_action :set_board, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]

  def index
    @tasks = @board.tasks
  end

  def show
    @task = @board.tasks.find(params[:id])
    @comments = @task.comments
  end

  def new
    @task = @board.tasks.new
  end

  def create
    @task = @board.tasks.build(task_params)
    @task.user = current_user
    if @task.save
      redirect_to board_task_path(@board, @task), notice: "タスクを作成しました"
    else
      flash.now[:error] = "タスクを作成できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = @board.tasks.find(params[:id])
  end

  def update
    @task = @board.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@board, @task), notice: "タスクを更新しました"
    else
      flash.now[:error] = "タスクを更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = @board.tasks.find(params[:id])
    @task.destroy!
    redirect_to board_tasks_path(@board), status: :see_other, notice: "タスクを削除しました"
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :image)
  end
end
