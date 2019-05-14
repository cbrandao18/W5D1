class ArtworksController < ApplicationController
    def index
        user = User.find(params[:user_id])
        total_artworks = user.artworks + user.shared_artworks
        render json: total_artworks
    end

    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: 422
        end
    end

    def show
        render json: Artwork.find(params[:id])
    end

    def update
        artwork = Artwork.find(params[:id])
        if artwork.update(artwork_params)
            render json: artwork
        else 
            render json: artwork.errors.full_messages, status: 422
        end
    end

    def destroy
        artwork = Artwork.find(params[:id])
        artwork.destroy
        render json: artwork
    end

    def like
        #like has a user_id, likeable_id, and likeable_type
        like = Like.new(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork')
        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: 422
        end
    end

    def unlike
        like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork')
        like.destroy
        render json: like
    end

    private

    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end
end