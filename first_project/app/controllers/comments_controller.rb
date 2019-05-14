class CommentsController < ApplicationController
    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment
        else
            render json: comment.errors.full_messages, status: 422
        end
    end

     def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end

    def index
        if params[:user_id] # get that users comments
            user = User.find(params[:user_id])
            comments = user.comments
            render json: comments
        elsif params[:artwork_id] # get the comments on that artwork
            artwork = Artwork.find(params[:artwork_id])
            comments = artwork.comments
            render json: comments
        else #get all the comments
            comments = Comment.all
            render json: comments
        end
    end

    def like
        #like has a user_id, likeable_id, and likeable_type
        like = Like.new(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')
        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: 422
        end
    end

    def unlike
        like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')
        like.destroy
        render json: like
    end

    private
    def comment_params
        params.require(:comment).permit(:user_id, :artwork_id, :body)
    end
end