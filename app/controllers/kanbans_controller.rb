class KanbansController < ApplicationController
  unloadable

  def index
    @issue_statuses = IssueStatus.sorted
    @issues_by_status = @issue_statuses.inject({}) do |result, issue_status|
      result[issue_status] = {
        sorted: [],
        unsorted: []
      }
      result
    end

    @project = Project.find(params[:project_id])
    project_issues = Issue.visible(User.current, :project => @project)
    if Setting.plugin_redhopper
      project_issues = project_issues.where(tracker: Setting.plugin_redhopper["displayed_tracker_ids"])
    end
    sorted_issues = RedhopperIssue.ordered

    sorted_issues.each do |issue|
      @issues_by_status[issue.issue.status][:sorted] << issue.issue if project_issues.include?(issue.issue)
    end

    project_issues.each do |issue|
      @issues_by_status[issue.status][:unsorted] << issue unless @issues_by_status[issue.status][:sorted].include?(issue)
    end
  end
end
