
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
                    menu.choice "No"
                end 
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