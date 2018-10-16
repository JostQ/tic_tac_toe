require_relative "BoardCase.rb"

class Board
    attr_reader :tab_board

    def initialize
        @tab_board = []
        compter = 1
        while compter < 10
            @tab_board << BoardCase.new(compter)
            compter += 1
        end
    end

    def display_board
        puts "1        |2        |3        "
        puts "    #{@tab_board[0].symbol}    |    #{@tab_board[1].symbol}    |    #{@tab_board[2].symbol}    "
        puts "_________|_________|_________"
        puts "4        |5        |6        "
        puts "    #{@tab_board[3].symbol}    |    #{@tab_board[4].symbol}    |    #{@tab_board[5].symbol}    "
        puts "_________|_________|_________"
        puts "7        |8        |9        "
        puts "    #{@tab_board[6].symbol}    |    #{@tab_board[7].symbol}    |    #{@tab_board[8].symbol}    "
        puts "         |         |         "
    end

end
