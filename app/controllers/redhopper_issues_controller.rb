class RedhopperIssuesController < ApplicationController
  unloadable

  def create
    redhopper_issue = RedhopperIssue.create(issue: Issue.find(params[:issue_id]))

    redirect_to project_kanbans_path(redhopper_issue.issue.project)
  end

  def move
    issue_to_move = RedhopperIssue.find(params[:id])
    target_issue = RedhopperIssue.find(params[:target_id])
    new_previous = target_issue

    if "before" == params[:insert]
      new_previous = target_issue.previous
    end

    if new_previous
      issue_to_move.append_to new_previous
    else
      issue_to_move.prepend
    end

    redirect_to project_kanbans_path(issue_to_move.issue.project)
  end

  def block
    issue_to_block = RedhopperIssue.find(params[:id])
    issue_to_block.blocked = true

    issue_to_block.save

    redirect_to project_kanbans_path(issue_to_block.issue.project)
  end

  def unblock
    issue_to_unblock = RedhopperIssue.find(params[:id])
    issue_to_unblock.blocked = false

    issue_to_unblock.save

    redirect_to project_kanbans_path(issue_to_unblock.issue.project)
  end

  def delete
    issue_to_delete = RedhopperIssue.find(params[:id])
    project = issue_to_delete.issue.project

    issue_to_delete.destroy

    redirect_to project_kanbans_path(project)
  end
end
