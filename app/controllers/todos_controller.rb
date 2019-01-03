class TodosController < ApplicationController

  def index
    @todo = Todo.new
    @todos = Todo.order(complete: :asc, priority: :desc, content: :asc)
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to todos_path
    else
      ## Needs changing
      redirect_to todos_path
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      redirect_to todos_path
    else
      ## Needs changing
      redirect_to todos_path
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to todos_path
  end

  def complete
    @todo = Todo.find(params[:id])
    @todo.update({ complete: !@todo.complete, priority: false })
    redirect_to todos_path
  end

  def priority
    @todo = Todo.find(params[:id])
    @todo.update({ priority: @todo.complete ? false : !@todo.priority })
    redirect_to todos_path
  end

  private
  def todo_params
    params.require(:todo).permit(:content)
  end

end
