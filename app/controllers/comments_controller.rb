class CommentsController < ApplicationController
  before_action :set_board_and_task, only: [ :new, :create ]

  def new
    @comment = @task.comments.build
  end

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to board_task_path(@board, @task), notice: "コメントを投稿しました。"
    else
      flash.now[:error] = "コメントを投稿できませんでした。入力内容をご確認ください。"
      render :new, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_board_and_task
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:task_id])
  end
end
