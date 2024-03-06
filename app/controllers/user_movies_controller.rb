class UserMoviesController < ApplicationController
  protect_from_forgery with: :null_session

  def current_user
    @current_user
  end
  
  def index
    p logged_in?
    p current_user
      @user_movies = current_user.movies
      if @user_movies.empty?
        render json: { message: 'No movies rated yet' }, status: 200
      else
        render json: @user_movies, status: 200
      end
  end

  # add new rate to movie
  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    :current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    if @user_movie.save
      render json: { message: 'Movie rated successfully' }, status: 201
    else
      render json: { errors: @user_movie.errors.full_messages }, status: 422
    end
    # redirect_to movies_path
  end

  #update movie rate
  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    if @user_movie.save
      render json: { message: 'Movie updated successfully' }, status: 200
    else
      render json: { errors: @user_movie.errors.full_messages }, status: 422
    end
    
    # redirect_to movies_path
  end
end
