require 'test_helper'

class TodoTest < ActiveSupport::TestCase

  def setup
    @todo1 = Todo.new
    @todo2 = Todo.new(content: "   ")
    @todo3 = Todo.new(content: "todo2 content")
  end

  test "should be valid" do
    assert @todo3.valid?
  end

  test "content should be present" do
    assert_not @todo1.valid?
    assert_not @todo2.valid?
  end

end
