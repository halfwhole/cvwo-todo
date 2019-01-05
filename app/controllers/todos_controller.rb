class TodosController < ApplicationController

  def index
    @todo = Todo.new
    @todos = Todo.order(complete: :asc, priority: :desc, content: :asc)
    @search_tags = session[:search_tags] || []
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

  ## TODO: Split 'tag' method into 'add_tag' and 'remove_tag' methods (also modify the view and routes.rb accordingly)
  def tag
    @todo = Todo.find(params[:id])
    if todo_tag[:tag].blank?
      redirect_to todos_path
      return
    end
    if @todo.tags.include? todo_tag[:tag]
      @todo.tags.delete(todo_tag[:tag])
    else
      @todo.tags.push(todo_tag[:tag])
    end
    @todo.save
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
  def todo_tag
    params.require(:todo).permit(:tag)
  end

  def todo_params
    params.require(:todo).permit(:content)
  end

end
