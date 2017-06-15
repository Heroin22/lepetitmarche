class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :ville_id
      t.string  :ville_departement
      t.string  :ville_slug,            null: true
      t.string  :ville_nom,            null: true
      t.string  :ville_nom_simple,            null: true
      t.string  :ville_nom_reel,            null: true
      t.string  :ville_nom_soundex,            null: true
      t.string  :ville_nom_metaphone,            null: true
      t.string  :ville_code_postal,            null: true
      t.string  :ville_commune,            null: true
      t.string  :ville_code_commune,            null: true
      t.integer  :ville_arrondissement,            null: true
      t.string  :ville_canton,            null: true
      t.integer  :ville_amdi,            null: true
      t.integer  :ville_population_2010,            null: true
      t.integer  :ville_population_1999,            null: true
      t.integer  :ville_population_2012,            null: true
      t.integer  :ville_densite_2010,            null: true
      t.float  :ville_surface,            null: true
      t.float  :ville_longitude_deg,            null: true
      t.float  :ville_latitude_deg,            null: true
      t.string  :ville_longitude_grd,            null: true
      t.string  :ville_latitude_grd,            null: true
      t.string  :ville_longitude_dms,            null: true
      t.string  :ville_latitude_dms,            null: true
      t.integer  :ville_zmin,            null: true
      t.integer  :ville_zmax,            null: true

      t.timestamps null: false
    end
    add_index :cities, :ville_id, unique: true
    add_foreign_key :cities, :departments, column: :ville_departement, primary_key: "departement_id"
  end
end
