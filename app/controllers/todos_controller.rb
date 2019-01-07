class TodosController < ApplicationController

  def index
    @todo = Todo.new
    @todos = Todo.order(complete: :asc, priority: :desc, content: :asc)
    @search_tags = session[:search_tags] || []
    if @search_tags.blank?
      @filtered_todos = @todos
    else
      @filtered_todos = @todos.select { |todo| (todo.tags & @search_tags).to_set == @search_tags.to_set }
    end
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.save
    redirect_to todos_path
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    redirect_to todos_path
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

  def add_tag
    @todo = Todo.find(params[:id])
    if !params[:tag].blank? and !(@todo.tags.include? params[:tag])
      @todo.tags.push(params[:tag])
      @todo.save
    end
    redirect_to todos_path
  end

  def remove_tag
    @todo = Todo.find(params[:id])
    if !params[:tag].blank?
      @todo.tags.delete(params[:tag])
      @todo.save
    end
    redirect_to todos_path
  end

  def add_search_tag
    session[:search_tags] ||= []
    if !params[:search_tag].blank? and !(session[:search_tags].include? params[:search_tag])
      session[:search_tags].push(params[:search_tag])
    end
    redirect_to todos_path
  end

  def remove_search_tag
    if session[:search_tags].include? params[:search_tag]
      session[:search_tags].delete(params[:search_tag])
    end
    redirect_to todos_path
  end

  private
  def todo_params
    params.require(:todo).permit(:content)
  end

end