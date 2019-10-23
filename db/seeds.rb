city = ["Atlanta", "Boston", "New York City", "Washington, D.C"]
payment = 5

u1 = Users.create(name: Faker::Name.name, balance: Faker::Number.decimal(l_digits: 2), location: city.sample)

b1 = Birds.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))

Orders.create(scooter_id: b1.id, user_id: u1.id, earnings: payment)