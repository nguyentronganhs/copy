require File.expand_path('../../test_helper', __FILE__)

class RedhopperIssuesControllerTest < ActionController::TestCase

  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :enabled_modules,
           :enumerations,
           :trackers,
           :projects_trackers

	def test_create
    expected_issue_id = 1
		post :create, :issue_id => expected_issue_id

		assert_redirected_to project_kanbans_path(Issue.find(expected_issue_id).project)
	end

end
