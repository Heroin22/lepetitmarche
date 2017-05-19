class Ad < ActiveRecord::Base
  scope :by_title, -> title {where("title LIKE '%?%'", :title)}
  scope :by_description, -> description {where("description LIKE '%?%'", :description)}
  scope :by_titleDescription, -> title, description {where("description LIKE '%?%' OR title LIKE '%?%'", :description, :title)}
  scope :by_category, -> category {where("category LIKE '%?%'", :category)}
  scope :by_region, -> region {where("region LIKE '%?%'", :region)}

end
