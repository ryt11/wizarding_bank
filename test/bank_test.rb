require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'
require './lib/person'

class TestBank < Minitest::Test
  def setup
    @bank = Bank.new("Wells Fargo")
    @second_bank = Bank.new("JP Morgan")
    @new_person = Person.new("Ronald", 500)
  end
  def test_bank_exists
    assert_instance_of Bank, @bank
  end 

  def test_bank_knows_its_name
    assert_equal "Wells Fargo", @bank.bank_name
  end

  def test_new_account_can_be_created
    assert_equal [@new_person, 0], @bank.open_account(@new_person)
    assert_equal "Ronald", @bank.accounts.key([@new_person, 0])
  end

  def test_it_can_deposit_galleons
    @bank.open_account(@new_person)
    assert_equal 300, @bank.deposit("Ronald", 200)
  end

  def test_does_it_limit_deposit_to_total_balance
    @bank.open_account(@new_person)
    assert_equal "Not enough funds available for deposit amount.", @bank.deposit("Ronald", 600)
  end
  def test_can_a_person_withdraw_acceptable_amount
    @bank.open_account(@new_person)
    @bank.deposit("Ronald", 200)
    assert_equal 100, @bank.withdraw("Ronald", 100)
  end

  def test_person_cant_overdraw_account
    @bank.open_account(@new_person)
    @bank.deposit("Ronald", 200)
    assert_equal "Not enough funds available for withdrawal request.", @bank.withdraw("Ronald", 9000)
  end

  def test_can_a_person_transfer_funds
    @bank.open_account(@new_person)
    @bank.deposit("Ronald", 200)
    @second_bank.open_account(@new_person)
    assert_equal 200, @bank.transfer(@new_person.name, @second_bank, 200)
  end

  def test_person_cant_overdraw_with_transfer
    @bank.open_account(@new_person)
    @bank.deposit("Ronald", 200)
    @second_bank.open_account(@new_person)
    assert_equal "Not enough funds available for transfer request.", @bank.transfer(@new_person.name, @second_bank, 8000)
  end

  def test_person_cant_transfer_funds_to_bank_they_dont_have_account_with
    @bank.open_account(@new_person)
    @bank.deposit("Ronald", 200)
    @bank.transfer(@new_person.name, @s econd_bank, 100)
    assert_equal "No account found for that name in JP Morgan database.", @bank.transfer(@new_person.name, @second_bank, 100)
  end
end
