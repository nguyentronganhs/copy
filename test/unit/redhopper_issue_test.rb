require File.expand_path('../../test_helper', __FILE__)

class RedhopperIssueTest < ActiveSupport::TestCase
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

  def test_highlight_class_when_not_blocked
    # Given
    redhopper_issue = RedhopperIssue.new issue: Issue.find(1)
    # When
    result = redhopper_issue.highlight_class
    #Then
    assert_equal '', result
  end

  def test_highlight_class_when_blocked_with_comment
    # Given
    redhopper_issue = RedhopperIssue.new issue: Issue.find(1)
    redhopper_issue.blocked = true
    # When
    result = redhopper_issue.highlight_class
    #Then
    assert_equal 'highlight_danger', result
  end

  def test_highlight_class_when_blocked_with_issue
    # Given
    blocked_issue = Issue.find(1)
    blocking_issue = Issue.find(2)
    IssueRelation.create!(
      :issue_from => blocking_issue, :issue_to => blocked_issue,
      :relation_type => IssueRelation::TYPE_BLOCKS
    )

    redhopper_issue = RedhopperIssue.new(issue: blocked_issue)
    # When
    result = redhopper_issue.highlight_class
    #Then
    assert_equal 'highlight_warning', result
  end

  def test_highlight_class_when_blocked_with_issue_and_with_comment
    # Given
    blocked_issue = Issue.find(1)
    blocking_issue = Issue.find(2)
    IssueRelation.create!(
      :issue_from => blocking_issue, :issue_to => blocked_issue,
      :relation_type => IssueRelation::TYPE_BLOCKS
    )

    redhopper_issue = RedhopperIssue.new(issue: blocked_issue)
    redhopper_issue.blocked = true
    # When
    result = redhopper_issue.highlight_class
    #Then
    assert_equal 'highlight_warning', result
  end

  def test_highlight_class_when_blocking_issue
    # Given
    blocked_issue = Issue.find(1)
    blocking_issue = Issue.find(2)
    IssueRelation.create!(
      :issue_from => blocking_issue, :issue_to => blocked_issue,
      :relation_type => IssueRelation::TYPE_BLOCKS
    )

    redhopper_issue = RedhopperIssue.new(issue: blocking_issue)
    # When
    result = redhopper_issue.highlight_class
    #Then
    assert_equal 'highlight_danger', result
  end

  def test_highlight_class_when_blocking_issue_blocked_with_comment
    # Given
    blocked_issue = Issue.find(1)
    blocking_issue = Issue.find(2)
    IssueRelation.create!(
      :issue_from => blocking_issue, :issue_to => blocked_issue,
      :relation_type => IssueRelation::TYPE_BLOCKS
    )

    redhopper_issue = RedhopperIssue.new(issue: blocking_issue)
    redhopper_issue.blocked = true
    # When
    result = redhopper_issue.highlight_class
    #Then
    assert_equal 'highlight_danger', result
  end

  def test_highlight_class_when_blocking_issue_blocked_with_issue
    # Given
    blocked_issue = Issue.find(1)
    blocking_blocked_issue = Issue.find(2)
    blocking_issue = Issue.find(3)
    IssueRelation.create!(
      :issue_from => blocking_issue, :issue_to => blocking_blocked_issue,
      :relation_type => IssueRelation::TYPE_BLOCKS
    )
    IssueRelation.create!(
      :issue_from => blocking_blocked_issue, :issue_to => blocked_issue,
      :relation_type => IssueRelation::TYPE_BLOCKS
    )

    redhopper_issue = RedhopperIssue.new(issue: blocking_blocked_issue)
    # When
    result = redhopper_issue.highlight_class
    #Then
    assert_equal 'highlight_warning', result
  end

end
