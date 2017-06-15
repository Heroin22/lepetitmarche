class AdController < ApplicationController

  def listAd
    @ads = Ad.all
  end

  def detailAd
    @ad = Ad.find_by(id: params[:id])
    @city = City.find_by(ville_id: @ad.city)
    @region = Department.find_by(departement_id: @ad.region)
    @category = Category.find_by(id: @ad.category)
  end

  def newAd
    @category = Category.all
    @department = Department.all
    @city = City.all
  end

  def createAd
    @region = params[:region]
    @city = params[:city]
    @category = params[:category]
    @title = params[:title]
    @description = params[:description]
    @price = params[:price]
    @image = params[:image]['datafile'].original_filename
    Datafile.save(params[:image])
    @userId = params[:userId]
    Ad.create({:region => @region, :city => @city, :category => @category, :title => @title, :description => @description, :price => @price, :image => @image, :userId => @userId});
    redirect_to(listAd_path)
  end

  def findAd
  end

  def modifyAd
  end

  def deleteAd
  end
end
