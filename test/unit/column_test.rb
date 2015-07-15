require File.expand_path('../../test_helper', __FILE__)

class ColumnTest < ActiveSupport::TestCase

  test ".initialize with issue status" do
    # When
    column = Column.new nil
    # Then
    assert_not_nil column
  end

  test ".issue_status returns the status from initialization" do
    # Given
    expected = IssueStatus.new name: 'To do'
    column = Column.new expected

    # When
    result = column.issue_status

    # Then
    assert_equal expected, result
  end

end
