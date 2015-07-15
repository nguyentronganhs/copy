require File.expand_path('../../test_helper', __FILE__)

class KanbanBoardTest < ActiveSupport::TestCase

  setup do
    @kanban_board = KanbanBoard.new
  end

  test ".initialize" do
    assert_not_nil @kanban_board
  end

  test ".columns returns all the issue statuses sorted" do
    # Given
    IssueStatus.delete_all
    doing = IssueStatus.create!(name: 'Doing')
    todo = IssueStatus.create!(name: 'To do')
    done = IssueStatus.create!(name: 'Done')
    doing.move_lower

    issue_statuses = [todo, doing, done]

    # When
    columns = @kanban_board.columns

    # Then
    assert_equal issue_statuses, columns
  end

end
