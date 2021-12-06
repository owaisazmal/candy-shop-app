class Candy

    attr_reader :name
    attr_accessor :shelved
     # Author Owais Khan 
     # Constructs candy object with name and shelved
    def initialize(name, shelved)
        @name = name
        @shelved = shelved
    end
    
end