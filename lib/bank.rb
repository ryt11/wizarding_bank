require './lib/person'
require 'pry'

class Bank
  attr_reader :bank_name
  attr_accessor :accounts
  def initialize (bank_name)
    @bank_name = bank_name
    @accounts = {}
  end

  def open_account (person)
    accounts[person.name] = [person, 0]
  end

  def deposit (name, deposit_amount)
    if accounts[name][0].galleons >= deposit_amount
       accounts[name][1] += deposit_amount
       accounts[name][0].galleons -= deposit_amount
    else
      "Not enough funds available for deposit amount."
    end
  end

  def withdraw (name, withdrawal_amount)
    account = accounts[name]
    if account[1] >= withdrawal_amount
      account[0].galleons += withdrawal_amount
      account[1] -= withdrawal_amount
    else
      "Not enough funds available for withdrawal request."
    end
  end

  def transfer (name, bank, transfer_amount)
    current_bank_account = accounts[name]
    transfer_account = bank.accounts[name]
  if bank.accounts.has_key?(name)
    if current_bank_account[1] >= transfer_amount
      current_bank_account[1] -= transfer_amount
      transfer_account[1] += transfer_amount
    else
      "Not enough funds available for transfer request."
    end
  else
    "No account found for that name in #{bank.bank_name} database."
  end
  end


end
