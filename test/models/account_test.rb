require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "new accounts with name, email, and password are saved" do
    acc = Account.new
    acc.name = 'name'
    acc.email = 'email'
    acc.password = 'password'
    assert acc.save
  end

  test "new accounts without name are not saved" do
    acc = Account.new({email: 'email', password:'pw'})
    assert_not acc.save
  end

  test "new accounts without email are not saved" do
    acc = Account.new({name:'name', password:'pw'})
    assert_not acc.save
  end

  test "new accounts without password are not saved" do
    acc = Account.new({name:'name', email:'email'})
    assert_not acc.save
  end

  test "duplicate email accounts are not saved" do
    acc1 = Account.new({name:'name', email:'email', password:'pw'})
    acc2 = Account.new({name:'name', email:'email', password:'pw'})
    assert acc1.save
    assert_not acc2.save
  end
end
