class SessionsController < ApplicationController
   
    skip_before_action :authorize, only: :create

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
    def create
        @user = User.find_by!(username: params[:username])

        if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        render json: @user, status: :created

        else
        render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
    end
    
    def destroy
        session.delete :user_id
        head :no_content
    end

    private 

    def render_not_found_response
        render json: { errors: ["User not found"] }, status: :unauthorized
    end

end