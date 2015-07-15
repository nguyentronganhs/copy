class KanbanBoard

	attr_reader :columns

	def initialize
		@columns_by_status = {}
		@columns = IssueStatus.sorted.map do |status|
			@columns_by_status[status] = Column.new status
		end
	end

	def column_for_issue_status status
		@columns_by_status[status]
	end

end
