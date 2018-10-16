class BoardCase

    attr_accessor :symbol
    attr_reader :id

    def initialize(id, symbol = " ")
        @symbol = symbol
        @id = id
    end

end
