require File.expand_path('../../test_helper', __FILE__)

class KanbansControllerTest < ActionController::TestCase

	def setup
		@todo = IssueStatus.create! name: 'To Do'
		@doing = IssueStatus.create! name: 'Doing'
		@done = IssueStatus.create! name: 'Done'

		@project = Project.create! name: 'Test Project', identifier: 'test-project'
	end

	def test_index
		get :index, :project_id => @project.id

		assert_response :success
		assert_template 'index'
		assert_not_nil assigns['issues_by_status']
	end
end
