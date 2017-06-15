class AdController < ApplicationController
  def listAd
    @ads = Ad.all
    @department = Department.all
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

  def trieDateUp
    respond_to do |format|
      format.json { render json: {"ad" => Ad.order(:created_at)}}
    end
  end

  def trieDateDown
    respond_to do |format|
      format.json { render json: {"ad" => Ad.order(created_at: :desc)}}
    end
  end

  def triePriceDown
    respond_to do |format|
      format.json { render json: {"ad" => Ad.order(price: :desc)}}
    end
  end

  def triePriceUp
    respond_to do |format|
      format.json { render json: {"ad" => Ad.order(:price)}}
    end
  end

  def search
    @SearchText = params[:searchText]
    @CategoryId = params[:categorieId]
    @DepartementId = params[:departementId]
    @VilleId = params[:villeId]
    if @CategoryId != "" && @DepartementId != "" && @VilleId != ""
      respond_to do |format|
        format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region AND city = :city) OR ( description like :searchTextDesc AND category = :category AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}",:city => "#{@VilleId}"})}}
      end
    elsif @CategoryId != "" && @VilleId != ""
      respond_to do |format|
        format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND city = :city) OR ( description like :searchTextDesc AND category = :category AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:city => "#{@VilleId}"})}}
      end
    elsif @CategoryId != "" && @DepartementId != ""
      respond_to do |format|
        format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region) OR (description like :searchTextDesc AND category = :category AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}"})}}
      end
    elsif @DepartementId != "" && @VilleId != ""
      respond_to do |format|
        format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region AND city = :city) OR (description like :searchTextDesc AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}",:city => "#{@VilleId}"})}}
      end
    elsif @CategoryId != ""
      respond_to do |format|
        format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category) OR (description like :searchTextDesc AND category = :category)",{:searchText => "#{@SearchText}%", :searchTextDesc => "#{@SearchText}%",:category => "#{@CategoryId}"})}}
      end
    elsif @DepartementId != ""
      respond_to do |format|
        format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region) OR (description like :searchTextDesc AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}"})}}
      end
    elsif @VilleId != ""
      respond_to do |format|
        format.json { render json: {"ad" => Ad.where("(title like :searchText AND city = :city) OR (description like :searchTextDesc AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:city => "#{@VilleId}"})}}
      end
    else
      respond_to do |format|
        format.json { render json: {"ad" => Ad.where("title like :searchText OR description like :searchTextDesc ",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%"})}}
      end
    end
  end

  def getVilleByDep
    @DepId = params[:depId]
    respond_to do |format|
      format.json { render json: {"ville" => City.where("ville_departement = :depId",{:depId => "#{@DepId}"}).order('ville_nom_simple asc')}}
    end
  end
end
