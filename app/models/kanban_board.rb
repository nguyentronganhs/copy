class KanbanBoard

	def columns
		IssueStatus.sorted.map { |status| Column.new status }
	end

end
