class Strategist::TransactionsController < ApplicationController


def index
  @transactions = Transaction.verified if params[:status] == 'verified'
  @transactions = Transaction.unverified if params[:status] == 'unverified'
  @transactions = Transaction.deleted if params[:status] == 'deleted'
  return @transactions if @transactions

  @deleted_transactions = Transaction.deleted
  @verified_transactions = Transaction.verified
  @unverified_transactions = Transaction.unverified
end

def edit
end

def update
  respond_to do |format|
    if @transaction.update_attributes(transaction_params)
      format.html { redirect_to dashboard_path, notice: "Transaction Verified Successfully!" }
      format.json { render json: @transaction }
    else
      format.html { render 'edit' }
      format.json { render json: @transaction.errors }
    end
  end
end

def destroy
end

private

  def transaction_params
    params.require(:transactions).permit(:status, :verifier_id)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_verifier
    current_user
  end

end
