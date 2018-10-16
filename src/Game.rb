#La classe game gère la partie et permet à toutes nos classes d'intéragir entres elles.
#Nous utilisons la gem Rainbow pour simplifier l'ajout de couleur dans notre affichage.

class Game

    def initialize #Initialisation du plateau et des joueurs
        @nul = false
        @board = Board.new
        @player1 = Player.new("", "#{Rainbow("X").red}")
        @player2 = Player.new("", "#{Rainbow("Y").green}")
        @restart = false
    end

    def ask_name_player(player1, player2) #On demande à chaque joueur son nom
        puts "Nom joueur 1 :"
        print "> "
        player1.name = gets.chomp #Et on le modifie dans chaque instance de la classe joueur
        puts "Bienvenue #{Rainbow(player1.name).bright}. Vous jouez les #{Rainbow("X").red}."

        puts "Nom joueur 2 :"
        print "> "
        player2.name = gets.chomp
        puts "Bienvenue #{Rainbow(player2.name).bright}. Vous jouez les #{Rainbow("Y").green}."
    end

    def random_start
        if Random.new.rand(2) == 0
            @player1.turn = true #Tirage au sort du joueur qui commence.
            puts "#{Rainbow(@player1.name).bright} commence !"
        else
            @player2.turn = true
            puts "#{Rainbow(@player2.name).bright} commence !"
        end
    end

#La fonction qui suit gère la victoire.
#On lui donne un joueur et elle vérifie si il remplit les conditions de victoire du morpion classique.
# (3 cases sur une ligne, une colonne ou une diagonale)
#Pour ça, on test chaque possibilité de victoire indépendamment.

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
            @board.tab_board.each do |boardcase| #Cette boucle là nous permet de gérer les matchs nuls.
                if boardcase.symbol == " "
                    compter += 1
                end
            end
            if compter == 0 #Si plus de cases vides dans le tableau. C'est un match nul.
                @nul = true
            end
        end
    end

    def turn(player_turn_on, player_turn_off)
        puts "#{Rainbow(player_turn_on.name).bright} - Choisis un chiffre entre 1 et 9 : "
        while true
            print "> " #La fonction tour, demande au joueur où il souhaite jouer.
            player_choice = gets.chomp
            if !/^[1-9]{1}$/.match(player_choice) #Gère les entrées autres que des chiffres entre 1 et 9.
                puts "Choisis un véritable chiffre, pas une lettre, un chiffre, UN SEUL !"
            else
                player_choice = player_choice.to_i
                player_choice -= 1
                if @board.tab_board[player_choice].symbol != " " #Et les entrées de cases déjà prises.
                    puts "Choisis une case vide :"
                else
                    break
                end
            end
        end #Dès que le tour est terminé le jeton "joueur en cour" passe à l'autre joueur.
        player_turn_on.turn = false
        player_turn_off.turn = true
        @board.tab_board[player_choice].symbol = player_turn_on.symbol
        win?(player_turn_on)
        system("clear") #Cette ligne nous permet d'avoir un affichage statique et non une console qui défile.
    end

    def restart_game #Avant de commencer une nouvelle partie,
        @player1.turn = false #Nous initialisons les variables de tour,
        @player2.turn = false #Et de victoire sur false.
        @player1.won = false
        @player2.won = false
        @board.tab_board.each do |boardcase| #Et nous vidons toutes les cases du tableau.
            boardcase.symbol = " "
        end
    end

    def start_game #Au lancement d'une partie
        ask_name_player(@player1, @player2) #On demande leurs noms aux joueurs
        while true #Et tant que les joueurs veulent jouer
            if @restart == true
                restart_game #On initialise tout
            end
            random_start #On choisit un joueur au hasard
            print "Pour commencer, appuyez sur Entrée."
            gets.chomp
            system("clear") #On nettoie la console
            while @player1.won != true && @player2.won != true && @nul != true #Tant qu'aucun joueur n'a gagné
                puts " #{Rainbow(@player1.name).red} vs #{Rainbow(@player2.name).green}"
                @board.display_board # On affiche la grille
                if @player1.turn == true
                    turn(@player1, @player2) #La méthode turn va demander aux joueurs ce qu'ils veulent jouer ...
                elsif @player2.turn == true
                    turn(@player2, @player1)
                end
            end
            puts " #{Rainbow(@player1.name).red} vs #{Rainbow(@player2.name).green}"
            @board.display_board
            if @player1.won == true #Dès qu'un joueur remplit les conditions de victoire
                puts "GG #{Rainbow(@player1.name).bright} !" #GG !
            elsif @player2.won == true
                puts "GG #{Rainbow(@player2.name).bright} !"
            elsif @nul == true
                puts "Match nul !"
            end
            puts "Voulez-vous rejouer ? (o / n)" #Et vous pouvez même repartir pour un tour
            print "> "
            user_restart = gets.chomp.downcase
            if user_restart == "non" || user_restart == "n" || user_restart == "no"
                @restart = false
                break #On casse la boucle si les joueurs ont eu assez de fun
            else
                @restart = true
            end
        end
    end

end
