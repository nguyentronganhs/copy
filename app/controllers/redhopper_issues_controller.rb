class RedhopperIssuesController < ApplicationController
  unloadable

  def create
    redhopper_issue = RedhopperIssue.create(issue: Issue.find(params[:issue_id]))

    redirect_to project_kanbans_path(redhopper_issue.issue.project)
  end
end
