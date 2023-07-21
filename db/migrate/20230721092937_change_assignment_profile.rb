class ChangeAssignmentProfile < ActiveRecord::Migration[5.2]
  def up
    remove_reference :assignments_profiles, :zone_job_profile, foreign_key: true
    add_reference :assignments_profiles, :profile, index: true, foreign_key: true
  end

  def down
    remove_reference :assignments_profiles, :profile, index: true, foreign_key: true
    add_reference :assignments_profiles, :zone_job_profile, foreign_key: true
  end
end
