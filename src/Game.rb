require_relative "Player.rb"
require_relative "Board.rb"

class Game

    def initialize
        @board = Board.new
        @nul = false
        @player1 = Player.new("", "#{Rainbow("X").red}")
        @player2 = Player.new("", "#{Rainbow("Y").green}")
    end

    def ask_name_player(player1, player2)
        puts "Nom joueur 1 :"
        print "> "
        player1.name = gets.chomp
        puts "Bienvenue #{Rainbow(player1.name).bright}. Vous jouez les #{Rainbow("X").red}."

        puts "Nom joueur 2 :"
        print "> "
        player2.name = gets.chomp
        puts "Bienvenue #{Rainbow(player2.name).bright}. Vous jouez les #{Rainbow("Y").green}."

        if Random.new.rand(2) == 0
            player1.turn = true
            puts "#{Rainbow(player1.name).bright} commence !"
        else
            player2.turn = true
            puts "#{Rainbow(player2.name).bright} commence !"
        end
        print "Pour commencer, appuyez sur Entrée."
        gets.chomp
        system("clear")
    end

    def win?(player)
        if @board.tab_board[0].symbol == player.symbol && @board.tab_board[1].symbol == player.symbol && @board.tab_board[2].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[3].symbol == player.symbol && @board.tab_board[4].symbol == player.symbol && @board.tab_board[5].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[6].symbol == player.symbol && @board.tab_board[7].symbol == player.symbol && @board.tab_board[8].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[0].symbol == player.symbol && @board.tab_board[3].symbol == player.symbol && @board.tab_board[6].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[1].symbol == player.symbol && @board.tab_board[4].symbol == player.symbol && @board.tab_board[7].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[2].symbol == player.symbol && @board.tab_board[5].symbol == player.symbol && @board.tab_board[8].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[2].symbol == player.symbol && @board.tab_board[4].symbol == player.symbol && @board.tab_board[6].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[0].symbol == player.symbol && @board.tab_board[4].symbol == player.symbol && @board.tab_board[8].symbol == player.symbol
            player.won = true
        else
            compter = 0
            @board.tab_board.each do |boardcase|
                if boardcase.symbol == " "
                    compter += 1
                end
            end
            if compter == 0
                @nul = true
            end
        end
    end

    def turn(player_turn_on, player_turn_off)
        puts "#{Rainbow(player_turn_on.name).bright} - Choisis un chiffre entre 1 et 9 : "
        while true
            print "> "
            player_choice = gets.chomp
            if !/^[1-9]{1}$/.match(player_choice)
                puts "Choisis un véritable chiffre, pas une lettre, un chiffre, UN SEUL !"
            else
                player_choice = player_choice.to_i
                player_choice -= 1
                if @board.tab_board[player_choice].symbol != " "
                    puts "Choisis une case vide :"
                else
                    break
                end
            end
        end
        player_turn_on.turn = false
        player_turn_off.turn = true
        @board.tab_board[player_choice].symbol = player_turn_on.symbol
        win?(player_turn_on)
        system("clear")
    end

    def start_game
        ask_name_player(@player1, @player2)
        while @player1.won != true && @player2.won != true && @nul != true
            puts " #{Rainbow(@player1.name).red} vs #{Rainbow(@player2.name).green}"
            @board.display_board
            if @player1.turn == true
                turn(@player1, @player2)
            elsif @player2.turn == true
                turn(@player2, @player1)
            end
        end
        puts " #{Rainbow(@player1.name).red} vs #{Rainbow(@player2.name).green}"
        @board.display_board
        if @player1.won == true
            puts "GG #{Rainbow(@player1.name).bright} !"
        elsif @player2.won == true
            puts "GG #{Rainbow(@player2.name).bright} !"
        elsif @nul == true
            puts "Match nul !"
        end
    end

end
