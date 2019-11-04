require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "only new accounts with name, email, and password are saved" do
    acc = Account.new
    acc.name = 'name'
    acc.email = 'email'
    acc.password = 'password'
    assert acc.save
  end
end
