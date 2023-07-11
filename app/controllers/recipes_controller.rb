class RecipesController < ApplicationController
    before_action :authorize

    def index
      recipes = Recipe.includes(:user)
      render json: recipes.as_json(include: {user: {only: [:username, :image_url, :bio]}}), status: :ok
    end

    def create
      user = User.find_by(id: session[:user_id])
      recipe = user.recipes.create(recipe_params)

      if recipe.valid?
        render json: recipe.as_json(include: {user: {only: [:username, :image_url, :bio]}}), status: :created
      else
        render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
      end
    end

    private

    def recipe_params
      params.permit(:title, :instructions, :minutes_to_complete)
    end

    def authorize
      unless session.include? :user_id
        render json: {errors: ["Not authorized"]}, status: :unauthorized
      end
    end

end

