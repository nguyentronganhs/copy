class KanbansController < ApplicationController
  unloadable

  def index
    @project = Project.find(params[:project_id])

    @kanban_board = KanbanBoard.new

    project_issues = Issue.visible(User.current, :project => @project)
    if Setting.plugin_redhopper
      project_issues = project_issues.where(tracker: Setting.plugin_redhopper["displayed_tracker_ids"])
    end
    sorted_issues = RedhopperIssue.ordered

    sorted_issues.each do |issue|
      @kanban_board.column_for_issue_status(issue.issue.status).sorted_issues << issue.issue if project_issues.include?(issue.issue)
    end

    project_issues.each do |issue|
      @kanban_board.column_for_issue_status(issue.status).unsorted_issues << issue unless @kanban_board.column_for_issue_status(issue.status).sorted_issues.include?(issue)
    end
  end
end
