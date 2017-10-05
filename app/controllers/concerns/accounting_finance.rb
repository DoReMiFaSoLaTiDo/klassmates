module AccountingFinance

  def perform_double_entry(transaction)
    contribution = Contribution.find(transaction.contribution_id)
    contribution.with_lock do
      if transaction.naira?
        # NairaAccount.create({tran_id: transaction.id, amount: transaction.amount, })
        contribution.naira_balance += transaction.amount if transaction.credit?
        contribution.naira_balance -= transaction.amount if transaction.debit?
      elsif transaction.us_dollar?
        contribution.us_dollar_balance += transaction.amount if transaction.credit?
        contribution.us_dollar_balance -= transaction.amount if transaction.debit?
      elsif transaction.gb_pound?
        contribution.gb_pound_balance += transaction.amount if transaction.credit?
        contribution.gb_pound_balance -= transaction.amount if transaction.debit?
      end
      contribution.save
    end
  end

end
