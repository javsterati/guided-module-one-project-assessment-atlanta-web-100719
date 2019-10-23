
class CommandLineInterface
    city = ["Atlanta", "Boston", "New York City", "Washington, D.C"]
        def greet
            puts "Welcome to Bird Chargers!"
            puts "Where you can make money charging Birds!"
            puts " "
            puts "========================"
            puts " "
            end

        def make_user
            puts "whats your name?"
            name = gets.chomp
            puts "what city are you in?"
            location = gets.chomp
            user = Users.create(name: name, balance: 0, location: location)
            puts "Thanks " + name + "! "
        end
end