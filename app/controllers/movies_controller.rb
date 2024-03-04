class MoviesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    @movies = Movie.all
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
    end
    render json: @movies.to_json(methods: :average_score)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      # redirect_to movies_path, notice: "Movie was successfully created."
      render json: { message: 'Movie was successfully created.' }, status: 201
    else
      # render :new
      render json: { errors: @movie.errors.full_messages }, status: 422
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
