class Api::TransactionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  before_action :authenticate_with_token!, only: [:update, :destroy]
  before_filter :set_transaction, only: [:show, :update, :destroy ]
  before_filter :set_user, only: [:show, :index, :create, :update, :destroy ]

  def index
    @transactions = Transaction.all
    render json: @transactions
  end

  def show
    render json: @transaction
  end

  def create
    @transaction = Transaction.new(approved_params)

    if @transaction.save
      render json: @transaction, status: 201
    else
      render json: { errors: @transaction.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(approved_params)
      # :update_account_balance if @transaction[:status] eql :verified     
      render json: @transaction, status: 201
    else
      render json: { errors: @transaction.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    head 204
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def approved_params
      # raise params.inspect
      params.require(:transaction).permit(:id, :owner_id, :amount, :tran_type,
      :currency, :status, :password_confirmation, :verifier_id)
    end

    def render_404
      render json: { error: "Record Not Found", status: 404 }
    end
end
