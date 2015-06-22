class KanbansController < ApplicationController
  unloadable

  def index
    @issue_statuses = IssueStatus.sorted
    empty_issues_by_status = @issue_statuses.inject({}) do |result, issue_status|
      result[issue_status] = []
      result
    end

    @project = Project.find(params[:project_id])
    @issues_by_status = Issue.visible(User.current, :project => @project).inject(empty_issues_by_status) do |result, issue|
      result[issue.status] << issue
      result
    end
  end
end
