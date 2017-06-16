class AdController < ApplicationController

  def listAd
    @ads = Ad.all
    @department = Department.all
    @categoriesP = Category.find_by_sql("SELECT * FROM categories WHERE categories.parent_category IS NULL")
  end

  def detailAd
    @ad = Ad.find_by(id: params[:id])
    @city = City.find_by(ville_id: @ad.city)
    @region = Department.find_by(departement_id: @ad.region)
    @category = Category.find_by(id: @ad.category)
  end

  def newAd
    @categoriesP = Category.find_by_sql("SELECT * FROM categories WHERE categories.parent_category IS NULL")
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

  def getDonneesAd
    @depId = params[:depId]
    @CityId = params[:cityId]
    @CategoryId = params[:categId]
    p params
    respond_to do |format|
      format.json { render json: { "dep" => Department.find_by(departement_id: @depId) ,
                                   "city" => City.find_by(ville_id: @CityId),
                                   "categ" => Category.find_by(id: @CategoryId)}}
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

  def searchWithSort
    @orderBy = params[:orderBy]
    @SearchText = params[:searchText]
    @CategoryId = params[:categorieId]
    @DepartementId = params[:departementId]
    @VilleId = params[:villeId]
    if @CategoryId != "" && @DepartementId != "" && @VilleId != ""
      respond_to do |format|
        if @orderBy == "dateDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region AND city = :city) OR ( description like :searchTextDesc AND category = :category AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}",:city => "#{@VilleId}"}).order(created_at: :desc)}}
        elsif @orderBy == "dateUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region AND city = :city) OR ( description like :searchTextDesc AND category = :category AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}",:city => "#{@VilleId}"}).order(:created_at)}}
        elsif @orderBy == "priceUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region AND city = :city) OR ( description like :searchTextDesc AND category = :category AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}",:city => "#{@VilleId}"}).order(:price)}}
        elsif @orderBy == "priceDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region AND city = :city) OR ( description like :searchTextDesc AND category = :category AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}",:city => "#{@VilleId}"}).order(price: :desc)}}
        end
      end
    elsif @CategoryId != "" && @VilleId != ""
      respond_to do |format|
        if @orderBy == "dateDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND city = :city) OR ( description like :searchTextDesc AND category = :category AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:city => "#{@VilleId}"}).order(created_at: :desc)}}
        elsif @orderBy == "dateUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND city = :city) OR ( description like :searchTextDesc AND category = :category AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:city => "#{@VilleId}"}).order(:created_at)}}
        elsif @orderBy == "priceUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND city = :city) OR ( description like :searchTextDesc AND category = :category AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:city => "#{@VilleId}"}).order(:price)}}
        elsif @orderBy == "priceDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND city = :city) OR ( description like :searchTextDesc AND category = :category AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:city => "#{@VilleId}"}).order(price: :desc)}}
        end
      end
    elsif @CategoryId != "" && @DepartementId != ""
      respond_to do |format|
        if @orderBy == "dateDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region) OR (description like :searchTextDesc AND category = :category AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}"}).order(created_at: :desc)}}
        elsif @orderBy == "dateUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region) OR (description like :searchTextDesc AND category = :category AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}"}).order(:created_at)}}
        elsif @orderBy == "priceUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region) OR (description like :searchTextDesc AND category = :category AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}"}).order(:price)}}
        elsif @orderBy == "priceDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category AND region = :region) OR (description like :searchTextDesc AND category = :category AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:category => "#{@CategoryId}",:region => "#{@DepartementId}"}).order(price: :desc)}}
        end
      end
    elsif @DepartementId != "" && @VilleId != ""
      respond_to do |format|
        if @orderBy == "dateDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region AND city = :city) OR (description like :searchTextDesc AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}",:city => "#{@VilleId}"}).order(created_at: :desc)}}
        elsif @orderBy == "dateUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region AND city = :city) OR (description like :searchTextDesc AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}",:city => "#{@VilleId}"}).order(:created_at)}}
        elsif @orderBy == "priceUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region AND city = :city) OR (description like :searchTextDesc AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}",:city => "#{@VilleId}"}).order(:price)}}
        elsif @orderBy == "priceDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region AND city = :city) OR (description like :searchTextDesc AND region = :region AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}",:city => "#{@VilleId}"}).order(price: :desc)}}
        end
      end
    elsif @CategoryId != ""
      respond_to do |format|
        if @orderBy == "dateDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category) OR (description like :searchTextDesc AND category = :category)",{:searchText => "#{@SearchText}%", :searchTextDesc => "#{@SearchText}%",:category => "#{@CategoryId}"}).order(created_at: :desc)}}
        elsif @orderBy == "dateUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category) OR (description like :searchTextDesc AND category = :category)",{:searchText => "#{@SearchText}%", :searchTextDesc => "#{@SearchText}%",:category => "#{@CategoryId}"}).order(:created_at)}}
        elsif @orderBy == "priceUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category) OR (description like :searchTextDesc AND category = :category)",{:searchText => "#{@SearchText}%", :searchTextDesc => "#{@SearchText}%",:category => "#{@CategoryId}"}).order(:price)}}
        elsif @orderBy == "priceDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND category = :category) OR (description like :searchTextDesc AND category = :category)",{:searchText => "#{@SearchText}%", :searchTextDesc => "#{@SearchText}%",:category => "#{@CategoryId}"}).order(price: :desc)}}
        end
      end
    elsif @DepartementId != ""
      respond_to do |format|
        if @orderBy == "dateDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region) OR (description like :searchTextDesc AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}"}).order(created_at: :desc)}}
        elsif @orderBy == "dateUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region) OR (description like :searchTextDesc AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}"}).order(:created_at)}}
        elsif @orderBy == "priceUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region) OR (description like :searchTextDesc AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}"}).order(:price)}}
        elsif @orderBy == "priceDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND region = :region) OR (description like :searchTextDesc AND region = :region)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:region => "#{@DepartementId}"}).order(price: :desc)}}

        end
      end
    elsif @VilleId != ""
      respond_to do |format|
        if @orderBy == "dateDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND city = :city) OR (description like :searchTextDesc AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:city => "#{@VilleId}"}).order(created_at: :desc)}}
        elsif @orderBy == "dateUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND city = :city) OR (description like :searchTextDesc AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:city => "#{@VilleId}"}).order(:created_at)}}
        elsif @orderBy == "priceUp"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND city = :city) OR (description like :searchTextDesc AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:city => "#{@VilleId}"}).order(:price)}}
        elsif @orderBy == "priceDown"
          format.json { render json: {"ad" => Ad.where("(title like :searchText AND city = :city) OR (description like :searchTextDesc AND city = :city)",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%",:city => "#{@VilleId}"}).order(price: :desc)}}
        end
      end
    else
      respond_to do |format|
        if @orderBy == "dateDown"
          format.json { render json: {"ad" => Ad.where("title like :searchText OR description like :searchTextDesc ",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%"}).order(created_at: :desc)}}
        elsif @orderBy == "dateUp"
          format.json { render json: {"ad" => Ad.where("title like :searchText OR description like :searchTextDesc ",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%"}).order(:created_at)}}
        elsif @orderBy == "priceUp"
          format.json { render json: {"ad" => Ad.where("title like :searchText OR description like :searchTextDesc ",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%"}).order(:price)}}
        elsif @orderBy == "priceDown"
          format.json { render json: {"ad" => Ad.where("title like :searchText OR description like :searchTextDesc ",{:searchText => "%#{@SearchText}%", :searchTextDesc => "%#{@SearchText}%"}).order(price: :desc)}}
        end
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
