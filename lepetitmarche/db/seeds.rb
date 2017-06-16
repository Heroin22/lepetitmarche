# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


categories = Category.create([
    {id: 1, name: 'Multimedia', parent_category: nil},
    {id: 2, name: 'Informatique', parent_category: 1},
    {id: 3, name: 'Jeux vidéo', parent_category: 1},
    {id: 4, name: 'Téléphonie', parent_category: 1},
    {id: 5, name: 'Véhicules', parent_category: nil},
    {id: 6, name: 'Voitures', parent_category: 5},
    {id: 7, name: 'Motos', parent_category: 5},
    {id: 8, name: 'Bateaux', parent_category: 5},
    {id: 9, name: 'Emploi', parent_category: nil},
    {id: 10, name: 'Offre d\'emploi', parent_category: 9},
    {id: 11, name: 'Maison', parent_category: nil},
    {id: 12, name: 'Meubles', parent_category: 11},
    {id: 13, name: 'Electroménager', parent_category: 11},
    {id: 14, name: 'Vêtements', parent_category: 11},
    {id: 15, name: 'Bricolage', parent_category: 11},
    {id: 16, name: 'Vacances', parent_category: nil},
    {id: 17, name: 'Campings', parent_category: 16},
    {id: 18, name: 'Hotel', parent_category: 16},
    {id: 19, name: 'Locations', parent_category: 16},
    {id: 20, name: 'Image & son', parent_category: 1}])