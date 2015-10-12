class RedhopperIssue < ActiveRecord::Base
  unloadable
  resort!

  belongs_to :issue
  attr_accessible :issue

  validates :issue, uniqueness: true

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

  def highlight_class
    blocked_with_issues? ? 'highlight_warning' : blocking_issue? || blocked? ? 'highlight_danger' : ''
  end
end
