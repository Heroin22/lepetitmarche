class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer :departement_id
      t.string :departement_codes,           null: true
      t.string :departement_nom,             null: true
      t.string :departement_nom_uppercase,   null: true
      t.string :departement_slug,            null: true
      t.string :departement_nom_soundex,     null: true

      t.timestamps null: false
    end
    add_index :departments, :departement_id, unique: true
  end
end
