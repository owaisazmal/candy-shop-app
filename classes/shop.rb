class Shop
    # Copyright and Author Owais Khan
    # reader->getters: shelves and unshelved_candies
    attr_reader :shelves, :unshelved_candies
   
    # Constructs the object with array of shelves and candies that are not in any shelf
    def initialize
        @shelves = []
        @unshelved_candies = []
    end

    # Creates new shelf object and adds it @shelves
    # Shelf name has to be unique
    def add_shelf(name)
        if(!find_if_duplicate_shelf_exists(name))
             @shelves << Shelf.new(name)
             puts "\nNew Shelf #{name} added."
             true
        end
    end

    # Makes candies in that shelf unshelved
    # by adding the candies to array of unshelved candies
    # and changing the value of shelved variable in 
    # each candy to false.
    # Finally deletes the shelf
    def remove_shelf(shelf_number)
        make_candies_unshelved(@shelves[shelf_number-1])
        @shelves.delete_at(shelf_number-1)
        puts "\nShelf deleted!"
    end

    # Displayes list of shelves
    def display_shelves
        if(@shelves.length <=0)
            puts "\nNo shelves"
        else
            display("Shelves",@shelves)
        end
    end

    # Displays list of unshelved candies
    def list_unshelved_candies
       display("Unshelved candies",@unshelved_candies)
    end

    # Creates new candy object and adds it @unshelved_candies
    # Shelf name has to be unique
    def add_candy(name)
        @unshelved_candies << Candy.new(name,false)
        puts "\nNew candy added!"
    end

    # Gets the candy and shelf from candy_number and
    # shelf_number params/
    # Deletes that candy from unshelved_candies
    # and adds the candy to that shelf
    def move_candy_to_shelf(candy_number,shelf_number)
        candy = @unshelved_candies[candy_number-1]
        shelf = @shelves[shelf_number-1]
        @unshelved_candies.delete_at(candy_number-1)
        shelf.add_candy(candy)
    end

    # Moves a candy to shelf 
    def move_candy_from_shelf(candy_number)
        count = 0
        @shelves.each.with_index(1) do |shelf,num|
            shelf.candies.each.with_index(0) do |candy,index|
                if(count == candy_number -1)
                     @unshelved_candies << candy
                     shelf.remove_candy(index)
                     return nil
                end
                count+=1
            end
        end
    end

    # Displays all shelved and unshelved candies
    def display_all_candies
        if(@unshelved_candies.length<=0 && count_shelved_candies<=0)
            puts "\nNo candies"
        else
            list_candies
            list_shelved_candies
        end
    end

  # This list of candies is displayed when a candy 
  # is to be removed from shelf
   def display_candies_with_shelve
     i = 0
     for shelf in @shelves
        i = shelf.display_candies_for_removal(i)
     end
   end

    # Finds the total number of candies in all shelves
    def count_shelved_candies
        count = 0
        for shelf in @shelves
            count+=shelf.candies.length
        end
        count
    end

    
    private
        def find_if_duplicate_shelf_exists(name)
           @shelves.find_index{|shelf| shelf.name == name}
        end

        def make_candies_unshelved(shelf)
            if(shelf.candies.length > 0)
                shelf.candies.map {|candy| candy.shelved=false }
                @unshelved_candies+=shelf.candies
            end
        end     

        def display(name,arr)
            puts "\n------------------------------"
            puts "    #{name}: #{arr.length}     "
            puts "------------------------------"
            arr.each.with_index(1) do |item, index|
               puts "#{index}. #{item.name}"
            end
            puts
        end

        def list_candies
            if(@unshelved_candies.length>0)
                display("Unshelved candies",@unshelved_candies)
            end
        end
    
        def list_shelved_candies
            if(count_shelved_candies>0)
                puts "\n------------------------------"
                puts "      Shelved Candies: #{count_shelved_candies}"
                puts "------------------------------"
                for shelf in @shelves
                    shelf.display_candies
                end
            end
        end
end