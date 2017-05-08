class Api::RolesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  # before_action :authenticate_with_token!, only: [:create]
  before_action :set_role, only: [:show, :update, :destroy]
  # before_action :set_user, only: [:index, :show, :index]

  def show
    render json: @role
  end

  def index
    render json: @role
  end

  def create
    role = Role.new(approved_params)
    if role.save
      render json: role, status: 201
    else
      render json: { errors: role.errors }, status: 422
    end
  end

  def update
    # raise ActiveRecord::RecordNotFound unless current_user.posts.include? @post

    if @role.update(approved_params)
      render json: @role, status: 200
    else
      render json: { errors: @role.errors }, status: 422
    end
  end

  def destroy
    # raise ActiveRecord::RecordNotFound unless current_user.posts.include? @post

    @role.destroy
    head 204
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def approved_params
      params.require(:role).permit(:id, :name, :description)
    end

    def render_404
      render json: { error: "Record Not Found", status: 404 }
    end
end
