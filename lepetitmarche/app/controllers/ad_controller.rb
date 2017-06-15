class AdController < ApplicationController
  def listAd
    @ads = Ad.all
  end

  def newAd
    @category = Category.all
    @department = Department.all
    @city = City.all
  end

  def create
    @region = params[:region]
    @city = params[:city]
    @category = params[:category]
    @title = params[:title]
    @userId = params[:userId]
    Ad.create({:region => @region, :city => @city, :category => @category, :title => @title, :userId => @userId});
    redirect_to(createAd_path)
  end

  def findAd
  end

  def modifyAd
  end

  def deleteAd
  end
end
