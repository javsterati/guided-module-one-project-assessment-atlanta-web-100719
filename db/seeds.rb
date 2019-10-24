
city = ["Atlanta", "New York City"]
payment = 5

u1 = User.create(name: Faker::Name.name, balance: Faker::Number.decimal(l_digits: 2), location: city.sample)

b1 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b2 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b3 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b4 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b5 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b6 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b6 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))  
b7 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b8 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b9 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b10 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b11 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b12 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b13 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b14 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b15 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b16 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b17 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b18 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))
b19 = Bird.create(location: city.sample, battery_percentage: Faker::Number.within(range: 1..100))

Order.create(scooter_id: b1.id, user_id: u1.id, earnings: payment)