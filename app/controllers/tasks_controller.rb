class TasksController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  # 一覧画面
  def index
    # 全件 → ログインしている人の全件
    @tasks = current_user.tasks.all.page(params[:page])
  end

  def show
    @task = Task.find(params[:id])
  end
  
  def new
    # 「ログインしている人の」「タスクを」「新規作成する」
    # Task → current_user.tasks
    @task = current_user.tasks.new
  end
  
  def create
    @task = current_user.tasks.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
    else 
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
end
 
 
 private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end