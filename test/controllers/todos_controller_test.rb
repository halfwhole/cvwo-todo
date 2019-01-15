require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest

  def setup
    @todo = Todo.new(content: 'test content', tags: ['test tag'])
    @todo.save
  end

  test "should get todos" do
    get todos_path
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post todos_path, params: { todo: { content: 'new content' } }
    end
    assert_redirected_to todos_path
  end

  test "should not create todo with empty content" do
    assert_no_difference('Todo.count') do
      post todos_path, params: { todo: { content: '   ' } }
    end
    assert_redirected_to todos_path
  end

  test "should update todo" do
    patch todo_path(@todo), params: { todo: { content: 'updated content' } }
    assert_redirected_to todos_path
    @todo.reload
    assert_equal 'updated content', @todo.content
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete todo_path(@todo)
    end
    assert_redirected_to todos_path
  end

  test "should complete/uncomplete todo" do
    patch complete_todo_path(@todo)
    @todo.reload
    assert @todo.complete
    assert_redirected_to todos_path
    patch complete_todo_path(@todo)
    @todo.reload
    assert_not @todo.complete
    assert_redirected_to todos_path
  end

  test "should priority/unpriority todo" do
    patch priority_todo_path(@todo)
    @todo.reload
    assert @todo.priority
    assert_redirected_to todos_path
    patch priority_todo_path(@todo)
    @todo.reload
    assert_not @todo.priority
    assert_redirected_to todos_path
  end

  test "should not priority todo if complete" do
    patch complete_todo_path(@todo)
    patch priority_todo_path(@todo)
    assert_not @todo.priority
    assert_redirected_to todos_path
  end

  test "should unpriority todo on complete" do
    patch priority_todo_path(@todo)
    patch complete_todo_path(@todo)
    assert_not @todo.priority
    assert_redirected_to todos_path
  end

  test "should add tag" do
    assert_difference('@todo.tags.length') do
      patch add_tag_todo_path(@todo), params: { tag: 'new test tag' }
      @todo.reload
    end
    assert_redirected_to todos_path
  end

  test "should not add duplicate tag" do
    assert_no_difference('@todo.tags.length') do
      patch add_tag_todo_path(@todo), params: { tag: 'test tag' }
      @todo.reload
    end
    assert_redirected_to todos_path
  end

  test "should remove tag" do
    assert_difference('@todo.tags.length', -1) do
      patch remove_tag_todo_path(@todo), params: { tag: 'test tag' }
      @todo.reload
    end
    assert_redirected_to todos_path
  end

  test "should not remove irrelevant tag" do
    assert_no_difference('@todo.tags.length') do
      patch remove_tag_todo_path(@todo), params: { tag: 'random test tag' }
      @todo.reload
    end
    assert_redirected_to todos_path
  end

  test "should add search tag" do
    assert_difference('session[:search_tags]') do
      post add_search_tag_todos_path, params: { search_tag: 'test search tag' }
    end
    assert_redirected_to todos_path
  end

end
