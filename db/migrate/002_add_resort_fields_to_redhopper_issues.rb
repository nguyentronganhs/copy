# Migration to add the necessary fields to a resorted model
class AddResortFieldsToRedhopperIssues < ActiveRecord::Migration
  # Adds Resort fields, next_id and first, and indexes to a given model
  def change
    add_column :redhopper_issues, :next_id, :integer
    add_column :redhopper_issues, :first,   :boolean
    add_index :redhopper_issues, :next_id
    add_index :redhopper_issues, :first
  end
end
