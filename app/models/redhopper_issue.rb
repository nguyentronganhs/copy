class RedhopperIssue < ActiveRecord::Base
  unloadable
  resort!

  belongs_to :issue
  attr_accessible :issue

  validates :issue, uniqueness: true

  def blocked_with_comment?
    blocked?
  end

  def blockers
    issue.relations_to.select {|ir| ir.relation_type == IssueRelation::TYPE_BLOCKS && !ir.issue_from.closed?}.map { |ir| ir.issue_from }
  end

  def blocked_with_issues?
    blockers.present?
  end

  def blocking_issue?
    issue.relations_from.detect {|ir| ir.relation_type == IssueRelation::TYPE_BLOCKS && !ir.issue_to.closed?}
  end

  def comments
    # Some issue updates set notes to nil or "" hence the inline SQL :(
    issue.journals.visible.where("LENGTH(journals.notes) > 0")
  end

  def sortable?
    persisted?
  end

  def due_delta
    issue.due_before ? DueDeltaPresenter.new(issue.due_before) : nil
  end

  # Presenter

  def highlight_class
    blocked_with_issues? ? 'highlight_warning' : blocking_issue? || blocked_with_comment? ? 'highlight_danger' : ''
  end
end
