require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest

  def setup
    @todo = Todo.new(content: 'test content')
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

  test "should not create todo" do
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

end
