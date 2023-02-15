class ChangeAssignateProfileToAssignmentsProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_reference :assignments_profiles, :profile, foreign_key: true, index: false
    add_reference :assignments_profiles, :zone_job_profile, foreign_key: true
  end
end
