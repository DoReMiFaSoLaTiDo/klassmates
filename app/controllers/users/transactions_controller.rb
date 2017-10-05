class Users::TransactionsController < ApplicationController
  before_action :set_authentication_method
  before_filter :set_transaction, only: [:edit, :update, :show, :destroy]
  before_filter :set_owner, only: [:new]
  before_filter :set_user, only: [:index, :new]

  def index
    @transactions = @owner.transactions
    @profile = Profile.find(@user.id)
  end

  def new
    @transaction = Transaction.new({owner_id: @owner.id, status: :unverified, contribution_id: @owner.contribution.id})
    @profile = Profile.find(@user.id)
  end

  def edit
  end

  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to dashboard_path, notice: "Transaction Created Successfully!" }
        format.json { render json: @transaction, status: 201 }
      else
        format.html { render 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update


    respond_to do |format|
      if @transaction.update_attributes(transaction_params)
        format.html { redirect_to dashboard_path, notice: "Transaction Edited Successfully!" }
        format.json { render json: @transaction, status: 201 }
      else
        format.html { render 'edit', notice: "Transaction Edited Successfully!" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end

    end
  end

  private
    def transaction_params
      params.require(:transaction).permit(:verifier_id, :currency, :contribution_id, :tran_type, :tran_date, :amount, :description, :owner_id, :status )
    end


    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def set_owner
      @owner = User.find(current_user.id)
    end

    def set_verifier
      @verifier = User.find(current_user.id)
    end

    def set_user
      @user = current_user
    end

end
