class RecipesController < ApplicationController 
    def index 
        @user = User.find(session[:user_id])
        @recipes = @user.recipes
        render json: @recipes
    end

    def create 
        @user = User.find(session[:user_id])
        @recipe = @user.recipes.create(recipe_params)

        if @recipe.valid?
            render json: @recipe, status: :created
            
        else
            render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private 

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end