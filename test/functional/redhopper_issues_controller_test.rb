require File.expand_path('../../test_helper', __FILE__)

class RedhopperIssuesControllerTest < ActionController::TestCase

  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :enabled_modules,
           :enumerations,
           :trackers,
           :projects_trackers

  def setup
    @kanban = RedhopperIssue.create! issue: Issue.find(1)
  end

  def test_create
    # Given
    requested_issue = Issue.find(2)
    # When
    assert_difference('RedhopperIssue.count', +1) do
      post :create, :issue_id => requested_issue.id
    end
    # Then
    assert_redirected_to project_kanbans_path(requested_issue.project)
  end

  def test_move_in_first_place
    # Given
    to_move_up = RedhopperIssue.create! issue: Issue.find(2)
    # When
    get :move, id: to_move_up.id, target_id: @kanban.id, insert: 'before'
    # Then
    assert_equal [to_move_up, @kanban], RedhopperIssue.ordered
    assert_redirected_to project_kanbans_path(to_move_up.issue.project)
  end

  def test_move_up_in_second_place
    # Given
    second_kanban = RedhopperIssue.create! issue: Issue.find(2)
    to_move_up = RedhopperIssue.create! issue: Issue.find(3)
    # When
    get :move, id: to_move_up.id, target_id: second_kanban.id, insert: 'before'
    # Then
    assert_equal [@kanban, to_move_up, second_kanban], RedhopperIssue.ordered
    assert_redirected_to project_kanbans_path(to_move_up.issue.project)
  end

  def test_move_down
    # Given
    to_move_up = RedhopperIssue.create! issue: Issue.find(2)
    # When
    get :move, id: @kanban.id, target_id: to_move_up.id, insert: 'after'
    # Then
    assert_equal [to_move_up, @kanban], RedhopperIssue.ordered
    assert_redirected_to project_kanbans_path(to_move_up.issue.project)
  end

end
