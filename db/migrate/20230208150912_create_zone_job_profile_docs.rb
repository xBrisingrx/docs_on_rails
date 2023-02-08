class CreateZoneJobProfileDocs < ActiveRecord::Migration[5.2]
  def change
    create_table :zone_job_profile_docs do |t|
      t.references :zone_job_profile, foreign_key: true
      t.references :document, foreign_key: true
      t.date :start_date, comment: "Inicio vigencia de el documento en esta zona perfil trabajo"
      t.date :end_date, comment: "Fin vigencia de el documento en esta zona perfil trabajo"
      t.integer :d_type, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
