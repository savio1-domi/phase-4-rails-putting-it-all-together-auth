class UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: 422
        else
            render json: {errors: user.errors.full_messages}, status: 422
        end
    end

    def show 
        user = User.find_by(id: session[:user_id])

        if user
            render json: user, status: :created
        else
            render json: {error: ["Not authorized"]}, status: :unauthorized
        end
    end

    private

    def user_params 
        params.permit(:id, :username, :password, :image_url, :bio)
    end

    def authorize 
        unless session.include? :user_id
            render json: {message: "Not authorized"}, status: :unauthorized
        end
    end
end

