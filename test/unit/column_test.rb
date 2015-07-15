require File.expand_path('../../test_helper', __FILE__)

class ColumnTest < ActiveSupport::TestCase

  setup do
    # Given
    @issue_status = IssueStatus.new name: 'To do'
    @column = Column.new @issue_status
  end

  test ".initialize with issue status" do
    # Then
    assert_not_nil @column
  end

  test ".issue_status returns the status from initialization" do
    # Given
    expected = @issue_status
    # When
    result = @column.issue_status
    # Then
    assert_equal expected, result
  end

  test ".unsorted_issues returns an empty array after initialization" do
    # Given
    expected = []
    # When
    result = @column.unsorted_issues
    # Then
    assert_equal expected, result
  end

  test ".sorted_issues returns an empty array after initialization" do
    # Given
    expected = []
    # When
    result = @column.sorted_issues
    # Then
    assert_equal expected, result
  end

end
