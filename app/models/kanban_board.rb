#
# Redhopper - Kanban boards for Redmine, inspired by Jira Agile (formerly known as
# Greenhopper), but following its own path.
# Copyright (C) 2015 infoPiiaf <contact@infopiiaf.fr>
#
# This file is part of Redhopper.
#
# Redhopper is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# Redhopper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with Redhopper.  If not, see <http://www.gnu.org/licenses/>.
#
class KanbanBoard

	attr_reader :columns

	def initialize project
		@project = project
		@columns_by_status = {}

		statuses = IssueStatus.sorted
		necessary_statuses = []
		WorkflowTransition.where(:tracker_id => project.trackers.map(&:id), :role_id => Role.all.map(&:id)).each do |transition|
			necessary_statuses << transition.old_status
			necessary_statuses << transition.new_status
		end
		statuses = statuses & necessary_statuses.uniq
		statuses = statuses.select { |status| !status.is_closed?  } if Feature.enabled("only_open_statuses")

		@columns = statuses.map do |status|
			@columns_by_status[status] = Column.new status
		end.compact

		project_issues = issues

		redhopper_issues = RedhopperIssue.ordered
		redhopper_issues.each do |redhopper_issue|
			issue = redhopper_issue.issue
			if project_issues.include?(issue)
				column_for_issue_status(issue.status).sorted_issues << redhopper_issue
				project_issues.delete issue
			end
		end

		project_issues.each do |issue|
			column_for_issue_status(issue.status).unsorted_issues << RedhopperIssue.new(issue: issue)
		end
	end

	private

	def column_for_issue_status status
		@columns_by_status[status]
	end

	def issues
		project_issues = Issue.visible(User.current, :project => @project)
		project_issues = project_issues.open if Feature.enabled("only_open_statuses")

		if Setting.plugin_redhopper && Setting.plugin_redhopper["hidden_tracker_ids"]
			wanted_tracker_ids = Tracker.pluck(:id).map(&:to_s) - Setting.plugin_redhopper["hidden_tracker_ids"]
			project_issues = project_issues.where(tracker: wanted_tracker_ids)
		end

		project_issues.to_a
	end

end
