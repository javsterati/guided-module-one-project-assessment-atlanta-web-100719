require "pry"
class CommandLineInterface
    
        def greet
            font = TTY::Font.new(:straight)
            puts font.write("BIRD")
            puts "Welcome to Bird Chargers!"
            puts "Where you can make money charging Birds!"
            puts "============================="
        end

        def users_prompted
            prompt = TTY::Prompt.new
            prompt.select("Are you a new user?") do |menu|
                menu.choice "Yes", -> { make_user }
                menu.choice "No", -> { log_in }
            end 
        end

        def users_reprompted
            puts "Welcome To Bird!"
            puts "Please try again!"
            users_prompted
        end 

        def exit
            puts "Thanks! See ya later!"
        end 

        
        def balance(userb)
            prompt = TTY::Prompt.new
            blob = userb
            puts "  "
            puts "Your current balance is:"
            puts userb.balance
            puts " "
            puts "Increase your balance by charging more Birds!"
                prompt.select("Recieve $5 for every Bird picked up!") do |menu|
                    menu.choice "CHARGE NOW", -> { birds(blob) }
                    menu.choice "EXIT", -> { exit }
                end       
        end 

        def pickfive(user)
            puts " "
            puts "Thank you #{user.username}, We've added $25 to your balance!"
            user.balance + 25.0
            puts "Your new balance is #{user.balance}"
            
        end

        def pickone(user)
            puts " "
            puts "Thank you #{user.username}, We've added $5 to your balance!"
        end 

        def pickmax(user, amount)
            puts " "
            puts "Thank you #{user.username}, You picked up #{amount} birds and We've added $#{amount * 5} to your balance!"
        end

        def birds(current_user)
            prompt = TTY::Prompt.new
                blanky = current_user
                city = current_user.location
                available_scooters = Bird.all.select { |bird| bird.location == city }
                chargable_scooters = available_scooters.select {|bird| bird.battery_percentage <= 75.0}
                    puts "   "
                    puts "There are #{chargable_scooters.count} available scooters to charge in your area!"
                    prompt.select("How many would you like to pick up and charge?") do |menu|
                        menu.choice "PICK UP 1 SCOOTER", -> { pickone(blanky) }
                        menu.choice "PICK UP 5 SCOOTERS", -> { pickfive(blanky) }
                        menu.choice "PICK UP MAX SCOOTERS", -> { pickmax(blanky,chargable_scooters.count) }
                    end
        end 
       
        def make_user
            prompt = TTY::Prompt.new
            puts "Input your information below to become a user!"
                charger = prompt.collect do 
                    key(:name).ask("What's your name?", required: true)
                    puts "============================================================"
                    puts "We are currently only available in Atlanta and New York City."
                    puts "============================================================"
                    key(:location).ask("Which of the two cities would you like to work in?", required: true)
                    puts "    "
                    puts "Thank You! Next, please type in your preffered username and password."
                    puts "    "
                    key(:username).ask("Username:", required: true)
                    key(:password).ask("Password:", required: true)
                end
                
                User.create(name: charger[:name], balance: 0, location: charger[:location], username: charger[:username], password: charger[:password])
                    puts "Welcome #{charger[:username]}! Thanks for signing up!"
                    log_in
        end 
        
         def log_in
            prompt = TTY::Prompt.new
                user = prompt.collect do
                    puts "Please log in."
                    puts "========="
                    key(:username).ask("Please enter your username now!")
                    puts "Thank you!"
                    puts " "
                    key(:password).ask("You may now your password:")

                end
                    find_result = User.find_by(username: user[:username], password: user[:password])
                        if find_result == nil
                            puts "======================"
                            puts "Not Found!, try again!"
                            prompt.select("What would you like to do?") do |menu|
                                puts " "
                                menu.choice "Try Again", -> { log_in }
                                menu.choice "Return to Menu", -> { users_reprompted }
                                menu.choice "Exit", -> { exit } 
                            end 
                        else 
                            puts " Welcome #{find_result.username}!"
                            puts " "
                            prompt.select("What would you like to do?") do |menu|
                                puts "     "
                                menu.choice "View my Balance", -> { balance(find_result)}
                                menu.choice "Charge Birds", -> { birds(find_result) }
                                menu.choice "Exit", -> { exit }
                                end 
                        
                        end      
        end
end
         