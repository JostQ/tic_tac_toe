class Player
    attr_accessor :name, :won, :turn
    attr_reader :symbol

    def initialize(name, symbol, turn = false, won = false)
        @name = name
        @symbol = symbol
        @won = won
    end

end
