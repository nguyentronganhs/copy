require File.expand_path('../../test_helper', __FILE__)

class DueDeltaPresenterTest < ActiveSupport::TestCase

  test "returns correct values when on time" do
    # Given
    due_delta = DueDeltaPresenter.new(Date.today + 2.days)
    # When
    value = due_delta.value
    title = due_delta.title
    css_class = due_delta.css_class
    abs_value = due_delta.abs_value
    # Then
    assert_equal 2, value
    assert_equal '.on_time', title
    assert_equal '', css_class
    assert_equal "2", abs_value
  end

  test "returns correct values when overdue" do
    # Given
    due_delta = DueDeltaPresenter.new(Date.today - 2.days)
    # When
    value = due_delta.value
    title = due_delta.title
    css_class = due_delta.css_class
    abs_value = due_delta.abs_value
    # Then
    assert_equal -2, value
    assert_equal '.overdue', title
    assert_equal 'overdue', css_class
    assert_equal "2", abs_value
  end

end
