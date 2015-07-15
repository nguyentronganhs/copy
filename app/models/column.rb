class Column

	attr_reader :issue_status
	attr_reader :unsorted_issues
	attr_reader :sorted_issues

	def initialize issue_status
		@issue_status = issue_status
		@unsorted_issues = []
		@sorted_issues = []
	end

end
