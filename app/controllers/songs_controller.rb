require 'sinatra/base'
require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end
  #
  post '/songs' do
    if !params["artist"]["name"].empty?
      @song = Song.create(params[:song])
      @song.artist = Artist.create(name: params[:artist][:name])
      @song.genre_ids = params[:genres]
      @song.save
    end
    # binding.pry
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end
  #
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end
  #
  # get 'songs/:slug/edit' do
  #
  # end

end
