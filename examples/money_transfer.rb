# See https://github.com/RichOrElse/greedy-dci/blob/master/test/money_transfer_test.rb

Log = method(:puts)
Account = Struct.new(:number, :balance)
NotEnoughFund = Class.new(StandardError)

module SourceAccount
  def decrease_balance_by(amount)
    raise NotEnoughFund, "Balance is below amount.", caller if balance < amount
    self.balance -= amount
  end
end

module DestinationAccount
  def increase_balance_by(amount)
    self.balance += amount
  end
end

TransferMoney = Greedy.context do |from, to|
  using from.as SourceAccount
  using to.as DestinationAccount

  def withdraw(amount)
    from.decrease_balance_by(amount)
    Log["Withdraw", amount, from]
  end

  def deposit(amount)
    to.increase_balance_by(amount)
    Log["Deposit", amount, to]
  end

  def call(amount:)
    withdraw(amount)
    deposit(amount)
  end
end
