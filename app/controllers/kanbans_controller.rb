class KanbansController < ApplicationController
  unloadable

  def index
    @project = Project.find(params[:project_id])

    @kanban_board = KanbanBoard.new @project
    @can_unsort = Feature.enabled "move_back_to_unsorted"
  end

end
