class KanbansController < ApplicationController
  unloadable

  def index
    @project = Project.find(params[:project_id])

    @kanban_board = KanbanBoard.new @project

    @feature_show_blockers = Feature.enabled("show_blockers")
    @feature_show_due_date = Feature.enabled("show_due_date")
    @feature_block_with_comment = Feature.enabled("block_with_comment")
  end
end
