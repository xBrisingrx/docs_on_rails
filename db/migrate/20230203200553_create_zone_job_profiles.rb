class CreateZoneJobProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :zone_job_profiles do |t|
      t.references :zone, foreign_key: true
      t.references :job, foreign_key: true
      t.references :profile, foreign_key: true
      t.integer :d_type, null: false
      t.date :start_date, comment: "Inicio vigencia de el perfil en el trabajo"
      t.date :end_date, comment: "Fin vigencia de el perfil en el trabajo"
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
