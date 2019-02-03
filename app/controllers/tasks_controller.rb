class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:denger] = 'タスクが投稿されませんでした'
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page]).per(10)
      render 'toppages/index'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に更新されました'
      redirect_to @task
    else
      flash.now[:denger] = 'タスクが更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
