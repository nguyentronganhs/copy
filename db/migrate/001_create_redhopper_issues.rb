class CreateRedhopperIssues < ActiveRecord::Migration
  def change
    create_table :redhopper_issues do |t|
      t.references :issue, index: true, foreign_key: true, null: false
    end
  end
end
