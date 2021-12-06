class Shelf
    
    attr_reader :name, :candies
    # Author Owais Khan 
    # Constructs shelf object with its name and array of candies
    def initialize(name)
        @candies = []
        @name = name
    end
    
    # Changes the value of shelved variable to true
    # and adds the candy to the array of candies
    def add_candy(candy)
        candy.shelved = true
        @candies << candy
        puts "Candy #{candy.name} moved to shelf #{@name}!"
    end

    # Removes a candy at index position candy_index
    def remove_candy(candy_index)
       @candies.delete_at(candy_index)
       puts "\nCandy removed from shelf!"
    end
   
   # Displays all candies in the shelf
    def display_candies
        if(@candies.length > 0)
            puts "\nCandies in Shelf #{@name}:"
            @candies.each.with_index(1) do |candy,index|
                puts "#{index}. #{candy.name}"
            end
        end
    end
    
    # Displays all candies when a candy is to be removed
    # from shelf
    def display_candies_for_removal(index)
        if(@candies.length > 0)
            for candy in @candies
                index+=1
                puts "#{index}. #{candy.name} [Shelf #{name}]"
            end
        end
        index
    end
end