namespace :admin do


  task :create => :environment do
    u = User.new
    STDOUT.puts "Create an admin user."
    STDOUT.puts "Type the admin email."
    u.email = STDIN.gets.chomp
    STDOUT.puts "Type the admin password."
    u.password = STDIN.gets.chomp
    u.first_name = "Admin"
    u.last_name = "User"
    u.address = "Some address"
    u.city = "City"
    u.state = "State"
    u.zipcode = "42321"
    u.add_role :admin
    u.save
  end

  task :recipe => :environment do
    puts "Creating recipe for this month"
    r = Recipe.find_or_create_by_month_and_year(
      name: "Seasonal Ale",
      description: "This recipe is great!  It is perfect for this season!",
      month: Date.today.month,
      year: Date.today.year,
      deadline: 20
    )
    r.save validate: false unless Recipe.current_recipe
  end

  task :init => [:create, :recipe]

end

desc "Pings PING_URL to keep a dyno alive"
task :dyno_ping do
  require "net/http"
  if ENV['PING_URL']
    puts "Running upkeep ping!"
    uri = URI(ENV['PING_URL'])
    Net::HTTP.get_response(uri)
  else
    puts "No PING_URL found..."
  end
end
