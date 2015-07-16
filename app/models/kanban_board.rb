class KanbanBoard

	attr_reader :columns

	def initialize project
		@columns_by_status = {}

		statuses = IssueStatus.sorted

		if Feature.enabled("only_necessary_columns")
			necessary_statuses = []
			WorkflowTransition.where(:tracker_id => project.trackers.map(&:id), :role_id => Role.all.map(&:id)).each do |transition|
				necessary_statuses << transition.old_status
				necessary_statuses << transition.new_status
			end
			statuses = statuses & necessary_statuses.uniq
		end

		@columns = statuses.map do |status|
			@columns_by_status[status] = Column.new status
		end

		project_issues = Issue.visible(User.current, :project => project)
		if Setting.plugin_redhopper
			project_issues = project_issues.where(tracker: Setting.plugin_redhopper["displayed_tracker_ids"])
		end
		sorted_issues = RedhopperIssue.ordered

		sorted_issues.each do |issue|
			column_for_issue_status(issue.issue.status).sorted_issues << issue.issue if project_issues.include?(issue.issue)
		end

		project_issues.each do |issue|
			column_for_issue_status(issue.status).unsorted_issues << issue unless column_for_issue_status(issue.status).sorted_issues.include?(issue)
		end
	end

	def column_for_issue_status status
		@columns_by_status[status]
	end

end
