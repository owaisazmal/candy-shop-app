#!/usr/bin/env ruby

require_relative 'classes/shop'
require_relative 'classes/shelf'
require_relative 'classes/candy'

# Author Owais Khan
# Welcome message to display on load
def display_welcome_message

    puts "|------- Welcome to Candy Shop  -------  |"


end

# User menu with options to choose from
def display_menu
    loop do
        puts "\nSelect an option:"
        puts "1. Add shelf"
        puts "2. Remove shelf"
        puts "3. Add candy"
        puts "4. Move candy to shelf"
        puts "5. Remove candy from shelf"
        puts "6. View all candies"
        puts "7. View all shelves"
        puts "8. Exit"
        print "\nEnter option[e.g. 1]> "
        select_option
    end
end

# User input will be stored in option variable
def select_option
    option = gets.chomp.to_i
    case option
        when 1
            add_new_shelf
        when 2
            remove_shelf
        when 3
            add_candy
        when 4
           move_candy_to_shelf
        when 5
            remove_candy_from_shelf
        when 6
           list_candies
        when 7
            list_shelves
        when 8
            puts "Leaving candy shop"
            exit!
        else
            puts "Enter a valid option"
    end
end

# Adds a new shelf to the shop 
# Shelf name has to be unique
def add_new_shelf
    loop do
       puts "Enter the name of shelf:"
       print "> "
       shelf_name = gets.chomp 
       if($shop.add_shelf(shelf_name))
          return
       else
         puts "\nShelf exists. Choose a different name."
       end
    end
end

# Removes shelf from shop
# User has to type a valid shelf number to remove it
# If no shelf exist, displays a message
def remove_shelf
    if($shop.shelves.length>0)
        $shop.display_shelves
        remove_shelf_with_input_validation
    else
        puts "\nNo shelf exists!"
    end
end

# Removes shelf if shelf number is valid i.e. it falls within array index range
def remove_shelf_with_input_validation
    puts "Enter the shelf number to remove:[e.g. 1]"
    print "> "
    shelf_number = gets.chomp.to_i
    
    if(find_input_validity($shop.shelves, shelf_number))
       $shop.remove_shelf(shelf_number)
    else
        puts "\nEnter a valid shelf number\n\n"
        remove_shelf_with_input_validation
    end
end

# Adds a candy to the shop
# User needs to enter the name of candy
def add_candy
  puts "Enter the name of candy:"
  print ">"
  candy_name = gets.chomp
  $shop.add_candy(candy_name)
end

# Moves a candy to a shelf
# List of candies and shelves will be displayed to user
# User needs to enter candy number and shelf number
def move_candy_to_shelf
    if($shop.unshelved_candies.length<=0)
        puts "\nNo unshelved candies found!"
    elsif($shop.shelves.length<=0)
        puts "\nNo shelves found!"
    else
        $shop.list_unshelved_candies
        candy_number = enter_candy_number
        $shop.display_shelves
        shelf_number = enter_shelf_number
        $shop.move_candy_to_shelf(candy_number,shelf_number)
    end
end

# Takes valid candy number input for moving it to shelf
# and returns the candy number
def enter_candy_number
    loop do
        puts "Step 1: Enter the candy number [e.g. 1]"
        print ">"
        candy_number = gets.chomp.to_i
        is_valid = find_input_validity($shop.unshelved_candies,candy_number)
        if(is_valid)
            return candy_number
        else
            puts "\nEnter a valid candy number\n"
            puts
        end
    end
end

# Takes valid shelf number input for moving a candy
# and returns the shelf number
def enter_shelf_number
    loop do
        puts "Step 2: Enter the shelf number to move your candy [e.g. 1]"
        print ">"
        shelf_number = gets.chomp.to_i
        is_valid = find_input_validity($shop.shelves,shelf_number)
        if(is_valid)
            return shelf_number
        else
            puts "\nEnter a valid shelf number\n"
            puts
        end
    end
end

# Removes a candy from shelf
# List of candies is first displayed to the user
# User needs to enter a valid candy number
def remove_candy_from_shelf
    if($shop.count_shelved_candies==0)
        puts "No candies found in shelf!"
    else
        $shop.display_candies_with_shelve
        remove_candy_from_shelf_with_validation
    end
end

# Removes candy from shelf if the candy number is valid
def remove_candy_from_shelf_with_validation
    loop do
        puts "Enter the candy number to remove"
        print ">"
        candy_number = gets.chomp.to_i
        puts
        is_valid = (1..$shop.count_shelved_candies).any? {|item| item == candy_number}
        if is_valid
            $shop.move_candy_from_shelf(candy_number)
            break
        else
            puts "\nEnter a valid candy number\n"
            puts
        end
    end
end

# Displays all candies
def list_candies
    $shop.display_all_candies
end

# Displays all shelves
def list_shelves
    $shop.display_shelves
end

# Returns true if the input is equal any number in 1..length+1
def find_input_validity(arr,input)
    (1..arr.length+1).any? {|item| item == input}
end


$shop = Shop.new
display_welcome_message
display_menu
