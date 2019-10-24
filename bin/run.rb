require_relative '../config/environment'

# cli is an instance of the class called CommandLineInterface
cli = CommandLineInterface.new
cli.greet
cli.users_prompted