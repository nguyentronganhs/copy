class DueDeltaPresenter

  def initialize(due_date)
    @due_date = due_date
  end

  def title
    on_time? ? '.on_time' : '.overdue'
  end

  def css_class
    on_time? ? '' : 'overdue'
  end

  def value
    (@due_date - Date.today).to_i
  end

  def abs_value
    value.abs.to_s
  end

  private

  def on_time?
    value > 0
  end
end
