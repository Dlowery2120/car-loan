require_relative './config/environment.rb'

def prompt 
   TTY::Prompt.new
end

def cars
   Car.all.map {|car| car.make}
end

def car_prices
   Car.all.map {|car| car.price}
end



def loan_downpayment
   @car_price = @car_choice.delete("^0-9").to_i
   @downpayment = prompt.ask("Please enter your minimum 20% downpayment:").to_i
      if @downpayment < (@car_price * 0.20)
         puts "Less than required payment!!!"
         @downpayment = prompt.ask("Please enter downpayment amount(Must be atleast 20%)").to_i
      elsif @downpayment > (@car_price * 0.20)
         puts "Got it!"
         sleep(1)
      end
   
end



def loan_bank_balance
   bank_balance1 = prompt.ask("Enter Bank Balance:").to_i
   while (bank_balance1 < @downpayment)
      puts "Not enough money in your account"
      bank_balance1 = prompt.ask("Enter Bank Balance:").to_i
      if(bank_balance1 > @downpayment)
         puts "Verifying balance...."
         balance = BankAccount.create(balance: bank_balance1)
         sleep(2)
         
      end
   end
   puts "Loan has been finalized. Thanks for shopping with us and enjoy your new car!"
   sleep(1.5)
end



def no_loan_balance
         @car_price = @car_choice.delete("^0-9").to_i
         bank_balance2 = prompt.ask("Enter Bank Balance:").to_i   
         if bank_balance2 < @car_price
            puts "Not enough money in your account"
            bank_balance2 = prompt.ask("Enter Bank Balance:").to_i
         elsif bank_balance2 > @car_price
            sleep(1.5)
            create_bank = BankAccount.create(balance: bank_balance2)
            puts "Verifying balance...."

         end
         sleep(1.5)
            puts "Verifying balance...."
            puts "Thanks for shopping with us and enjoy your new car!"
      
end

#----------------------------------------------------------------------------------------------

def welcome
    title = Artii::Base.new(:font => "slant")
    puts "Welcome to:"
    puts title.asciify("My 64 Cars")
    sleep(1)
    puts "We'll have you cruising in no time!!"
    sleep(1)
end

def select_dealerships
   choose_dealership = prompt.select("Choose your local dealership!", [
   "Texas Direct Auto", "Car Max", "Car Cabanna", "Wheel Deal", "Exit"])
   @car_choice = prompt.select("Here's what we got!", 
   "#{cars[rand(cars.length)]} - $#{car_prices[rand(car_prices.length)]}",
   "#{cars[rand(cars.length)]} - $#{car_prices[rand(car_prices.length)]}",
   "#{cars[rand(cars.length)]} - $#{car_prices[rand(car_prices.length)]}",
   "#{cars[rand(cars.length)]} - $#{car_prices[rand(car_prices.length)]}",
   "#{cars[rand(cars.length)]} - $#{car_prices[rand(car_prices.length)]}",
   "#{cars[rand(cars.length)]} - $#{car_prices[rand(car_prices.length)]}",
   "#{cars[rand(cars.length)]} - $#{car_prices[rand(car_prices.length)]}",
   )
   puts "Ah the #{@car_choice}....good choice!"
   sleep(1.5)
end

def loan_menu
      menu_choices = prompt.select("Do you need a loan?", ["Yes", "No", "Exit"])
   
      if menu_choices == "Yes"
         loan_name = prompt.ask("What is your name?:") 
         loan_credit = prompt.ask("What is your credit score?:").to_i
            sleep(1)
         loan_user = User.create(name: loan_name, credit_score: loan_credit)
            if loan_credit < 600
               puts "SORRY, a credit score of #{loan_credit} is too low!"
               sleep(2)
               loan_menu
            elsif loan_credit > 600
             puts "Great!"
            end
         loan_downpayment
         loan_bank_balance

      elsif menu_choices == "No"
         loan_name = prompt.ask("What is your name?:") 
         
         puts "Great! We'll need a full payment up front."
         no_loan_balance
        
      elsif menu_choices == "Exit"
         exit!
      end
end
#----------------------------------------------------------------------------------------------

welcome
select_dealerships
loan_menu

