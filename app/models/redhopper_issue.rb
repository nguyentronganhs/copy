class RedhopperIssue < ActiveRecord::Base
  unloadable
  resort!

  belongs_to :issue
  attr_accessible :issue

  validates :issue, uniqueness: true
end
