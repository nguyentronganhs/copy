require File.expand_path('../../test_helper', __FILE__)

class KanbanBoardTest < ActiveSupport::TestCase

  setup do
    # Given
    IssueStatus.delete_all
    @doing = IssueStatus.create!(name: 'Doing')
    @todo = IssueStatus.create!(name: 'To do')
    @done = IssueStatus.create!(name: 'Done')
    @doing.move_lower && @todo.reload && @doing.reload

    @kanban_board = KanbanBoard.new
  end

  test ".initialize" do
    assert_not_nil @kanban_board
  end

  test ".columns returns all the issue statuses sorted wrapped in columns" do
    # When
    result = @kanban_board.columns

    # Then
    [@todo, @doing, @done].each_with_index do |status, index|
      assert_equal status, result[index].issue_status
    end
  end

  test ".column_for_issue_status returns the right column" do
    expected = @done

    # When
    result = @kanban_board.column_for_issue_status expected

    # Then
    assert_equal expected, result.issue_status
  end

end
