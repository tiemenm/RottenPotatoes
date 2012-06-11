class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    logger.debug params["ratings"]
    logger.debug request.fullpath
    @sortBy = params["sortBy"]
    @all_ratings = Movie.all_ratings
   
    sort_by_sql = "created_at ASC" 
    if @sortBy == "title"
        sort_by_sql = "title ASC"
    elsif @sortBy == "releaseDate"
        sort_by_sql = "release_date ASC"
    end
    @ratings_filter = params["ratings"]
    conditions = ["rating IN (?)", params["ratings"].each_key] if params["ratings"]
    @movies = Movie.find(:all, :conditions => conditions, :order => sort_by_sql)
    #logger.debug @movies
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
