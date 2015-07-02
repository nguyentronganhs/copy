class RedhopperIssuesController < ApplicationController
  unloadable

  def create
    redhopper_issue = RedhopperIssue.create(issue: Issue.find(params[:issue_id]))

    redirect_to project_kanbans_path(redhopper_issue.issue.project)
  end

  def move_up
    issue_to_move_up = RedhopperIssue.where(issue_id: params[:issue_id]).first
    issue_to_move_down = RedhopperIssue.where(issue_id: params[:insert_before_id]).first

    if issue_to_move_down.previous
      issue_to_move_up.append_to issue_to_move_down.previous
    else
      issue_to_move_up.prepend
    end

    redirect_to project_kanbans_path(issue_to_move_up.issue.project)
  end

end
