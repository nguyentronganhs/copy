class AddBlockedToRedhopperIssues < ActiveRecord::Migration
  def change
    add_column :redhopper_issues, :blocked, :boolean, default: false
  end
end
