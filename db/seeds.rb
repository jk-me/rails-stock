# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# account  id: 2, name: "Bob", email: "bob@bob.com", password: pw
# acc = Account.find_by(id:5)
acc = Account.create({name: "pi", email: "pi@pi.com", password:"pw"})

s1 = Stock.create({account: acc, symbol: "AAPL", shares: 100})
s2 = Stock.create({account: acc, symbol: "IBM", shares: 50})
# s3 = Stock.create({account: acc, symbol: "CHWY", shares: 270})

t1 = Transaction.create({account: acc, symbol: "AAPL", shares: 50, price: "99.99"})
t2 = Transaction.create({account: acc, symbol: "IBM", shares: 50, price: "123.45"})
# t3 = Transaction.create({account: acc, symbol: "CHWY", shares: 270, price: "36.70"})
t4 = Transaction.create({account: acc, symbol: "AAPL", shares: 50, price: "79.99"})



acc.stocks << [s1, s2]
acc.transactions << [t1, t2, t4]
