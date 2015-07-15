class KanbanBoard

	def columns
		IssueStatus.sorted.to_a
	end

end
