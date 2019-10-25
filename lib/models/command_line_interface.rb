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

        def orders(user)
        prompt = TTY::Prompt.new
        #prior_orders = Order.find_by(user_id: user) -> old code, updated it now. oct/25
        prior_orders = Order.where(user_id: user).all
           puts " "
           puts "Here are all previous orders affiliated with your account:"
           puts prior_orders
           puts " "
                prompt.select("What would you like to do now?") do |menu|
                    puts " "
                    menu.choice "Return to Account Page", -> { log_in }
                    menu.choice "Exit", -> { exit } 
                end
        end 

        def users_reprompted
            puts "Welcome To Bird!"
            puts "Please try again!"
            users_prompted
        end 

        def deleteaccount(user)
           user.destroy
           puts "Your account is now deleted."
         end
            
         def usure(user)
            prompt = TTY::Prompt.new
            bob = user
            puts " "
            puts "Are you sure you want to delete your account?"
            prompt.select("You will lose all available balance.") do |menu|
                menu.choice "Yes", -> { deleteaccount(bob) }
                menu.choice "No", -> { log_in }
            end 
         end
            
        
        def exit
            puts "Thanks! See ya later!"
            puts " "
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

        def pickone(user, bird)
            prompt = TTY::Prompt.new
            user.update(:balance => user.balance + 5.0)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            puts " "
            puts "Thank you #{user.username}, We've added $5 to your balance!"
            puts  "Your new balance is #{user.balance}"
                prompt.select("What would you like to do now?") do |menu|
                    puts " "
                    menu.choice "Return to Account Page", -> { log_in }
                    menu.choice "Exit", -> { exit }
                end    
        end 

        def pickthree(user, bird)
            prompt = TTY::Prompt.new
            user.update(:balance => user.balance + 15.0) 
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            puts " "
            puts "Thank you #{user.username}, We've added $15 to your balance!"
            puts "Your new balance is #{user.balance}"
                prompt.select("What would you like to do now?") do |menu|
                    puts " "
                    menu.choice "Return to Account Page", -> { log_in }
                    menu.choice "Exit", -> { exit }
                end
        end

        def pickseven (user, bird)
            prompt = TTY::Prompt.new
            user.update(:balance => user.balance + 35.0)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            Order.create(scooter_id: bird.id, user_id: user.id, earnings: 5)
            puts " "
            puts "Thank you #{user.username}, We've added $35 to your balance!"
            puts "Your new balance is #{user.balance}"
                prompt.select("What would you like to do now?") do |menu|
                    puts " "
                    menu.choice "Return to Account Page", -> { log_in }
                    menu.choice "Exit", -> { exit }
                end 
        end 

        def birds(current_user)
            prompt = TTY::Prompt.new
                blanky = current_user
                city = current_user.location
                available_scooters = Bird.all.select { |bird| bird.location == city }
                chargable_scooters = available_scooters.select {|bird| bird.battery_percentage <= 75.0}
                bird = chargable_scooters.sample
                    puts "   "
                    puts "There are #{chargable_scooters.count} available scooters to charge in your area!"
                    puts "You can pick up a max of 7 scooters at a time."
                    puts " "
                    prompt.select("How many would you like to pick up and charge?") do |menu|
                        menu.choice "PICK UP 1 SCOOTER", -> { pickone(blanky, bird) }
                        menu.choice "PICK UP 3 SCOOTERS", -> { pickthree(blanky, bird) }
                        menu.choice "PICK UP 7 SCOOTERS", -> { pickseven(blanky,bird) }
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
                    puts " "
                    puts "Which of the two cities would you like to work in?"
                    key(:location).ask("please note: response is case sensitive.", required: true)
                    puts "    "
                    puts "Thank You! Next, please type in your preffered username and password."
                    puts "    "
                    key(:username).ask("Username:", required: true)
                    key(:password).ask("Password:", required: true)
                end
                
                User.create(name: charger[:name], balance: 0.0, location: charger[:location], username: charger[:username], password: charger[:password])
                    puts ""
                    puts "Welcome #{charger[:username]}! Thanks for signing up!"
                    log_in
        end 
        
         def log_in
            prompt = TTY::Prompt.new
                user = prompt.collect do
                    puts " "
                    puts "Please log in."
                    puts "========="
                    key(:username).ask("Please enter your username:")
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
                                menu.choice "View Previous Orders", -> { orders(find_result) }
                                menu.choice "Charge Birds", -> { birds(find_result) }
                                menu.choice "Exit", -> { exit }
                                puts " "
                                menu.choice "DELETE ACCOUNT", -> { usure(find_result) }
                                end 
                        end      
        end
end
         