require File.expand_path('../../test_helper', __FILE__)

class KanbanBoardTest < ActiveSupport::TestCase
  fixtures :users

  setup do
    # Given
    Feature.stubs(:enabled).returns(false)
    User.current = User.find 1

    Role.delete_all
    @dev = Role.create!(name: 'Dev')

    IssueStatus.delete_all
    @done = IssueStatus.create!(name: 'Done', is_closed: true)
    @doing = IssueStatus.create!(name: 'Doing')
    @todo = IssueStatus.create!(name: 'To do')
    @doing.move_lower && @todo.reload && @doing.reload
    @done.move_to_bottom && @todo.reload && @doing.reload && @done.reload

    Tracker.delete_all
    @story = Tracker.create!(name: 'Story', default_status: @todo)
    @bug = Tracker.create!(name: 'Bug', default_status: @doing)

    WorkflowTransition.delete_all
    WorkflowTransition.create!(:role_id => @dev.id, :tracker_id => @story.id, :old_status_id => @doing.id, :new_status_id => @done.id)
    WorkflowTransition.create!(:role_id => @dev.id, :tracker_id => @story.id, :old_status_id => @todo.id, :new_status_id => @doing.id)
    WorkflowTransition.create!(:role_id => @dev.id, :tracker_id => @bug.id, :old_status_id => @doing.id, :new_status_id => @done.id)

    Project.delete_all
    @project = Project.create! name: 'Test Project', identifier: 'test-project'

    IssuePriority.delete_all
    @priority = IssuePriority.create! name:'Normal'

    Issue.delete_all
    @issue_todo = Issue.create!(subject: "Issue 1", project: @project, tracker: @story, status: @todo, priority: @priority, author: User.current)
    @issue_doing = Issue.create!(subject: "Issue 1", project: @project, tracker: @bug, status: @doing, priority: @priority, author: User.current)
    @issue_done = Issue.create!(subject: "Issue 1", project: @project, tracker: @story, status: @done, priority: @priority, author: User.current)

    RedhopperIssue.delete_all
    @kanban_issue_doing = RedhopperIssue.create! issue: @issue_doing
    @kanban_issue_done = RedhopperIssue.create! issue: @issue_done

    @kanban_board = KanbanBoard.new @project.reload
  end

  test ".initialize with project" do
    assert_not_nil @kanban_board
  end

  test ".columns returns all the issue statuses sorted wrapped in columns" do
    # Given
    expected = [@todo, @doing, @done]

    # When
    result = @kanban_board.columns

    # Then
    assert_equal expected.length, result.length
    expected.each_with_index do |status, index|
      assert_equal status, result[index].issue_status
    end
  end

  test ".columns returns only the necessary columns for project trackers" do
    # Given
    expected = [@doing, @done]
    @kanban_board = KanbanBoard.new Project.create!(name: 'Bugs Project', identifier: 'bugs-project', trackers: [@bug])

    # When
    result = @kanban_board.columns

    # Then
    assert_equal expected.length, result.length
    expected.each_with_index do |status, index|
      assert_equal status, result[index].issue_status
    end
  end

  test ".columns returns only the necessary columns for project trackers sorted" do
    # Given
    expected = [@todo, @doing, @done]
    @kanban_board = KanbanBoard.new Project.create!(name: 'Bugs Project', identifier: 'bugs-project', trackers: [@story])

    # When
    result = @kanban_board.columns

    # Then
    assert_equal expected.length, result.length
    expected.each_with_index do |status, index|
      assert_equal status, result[index].issue_status
    end
  end

  test ".columns returns only the columns for open statuses" do
    # Given
    Feature.stubs(:enabled).with("only_open_statuses").returns(true)

    expected = [@todo, @doing]
    @kanban_board = KanbanBoard.new Project.create!(name: 'Bugs Project', identifier: 'bugs-project')

    # When
    result = @kanban_board.columns

    # Then
    assert_equal expected.length, result.length
    expected.each_with_index do |status, index|
      assert_equal status, result[index].issue_status
    end
  end

  test ".column_for_issue_status returns the right column" do
    expected = @done

    # When
    result = @kanban_board.send :column_for_issue_status, expected

    # Then
    assert_equal expected, result.issue_status
  end

  test ".issues returns an array" do
    # When
    result = @kanban_board.send :issues
    # Then
    assert_instance_of Array, result
  end

  test ".issues returns all visible issues for project" do
    # Given
    expected = [@issue_todo, @issue_doing, @issue_done]
    # When
    result = @kanban_board.send :issues
    # Then
    assert_equal expected, result
  end

  test ".issues returns only open issues" do
    # Given
    Feature.stubs(:enabled).with("only_open_statuses").returns(true)
    expected = [@issue_todo, @issue_doing]
    # When
    result = @kanban_board.send :issues
    # Then
    assert_equal expected, result
    Feature.stubs(:enabled).with("only_open_statuses").returns(false)
  end

  test ".issues returns only issues with displayed trackers" do
    # Given
    Setting.plugin_redhopper = { "hidden_tracker_ids" => [ @bug.id.to_s ] }
    expected = [@issue_todo, @issue_done]
    # When
    result = @kanban_board.send :issues
    # Then
    assert_equal expected, result
    Setting.plugin_redhopper = nil
  end

end
