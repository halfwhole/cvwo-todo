class TodosController < ApplicationController

  def index
    @todos = Todo.all
  end

  def create
    @todo = Todo.new(todos_params)
    if @todo.save
      redirect_to todos_path
    else
      render 'new'
    end
  end

  def new
    @todo = Todo.new
  end

  private
  def todos_params
    params.require(:todo).permit(:content)
  end

end
