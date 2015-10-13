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

		assert_not_nil assigns['kanban_board']
	end
end