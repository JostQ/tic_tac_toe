#Pour chaque partie, nous aurons 2 joueurs.
#Le joueur a un nom, un variable (true ou false) disant si c'est ou non à lui de jouer, 
#Ainsi qu'un variable indiquant si le joueur a gagné ou non (là aussi true ou false).
#Le premier booléen nous permet de créer une seule fonction pour le tour du joueur 1 ou 2.
#Le deuxième nous permet de sortir de notre partie lorsqu'un des deux a gagné.

class Player
    attr_accessor :name, :won, :turn
    attr_reader :symbol

    def initialize(name, symbol, turn = false, won = false)
        @name = name
        @symbol = symbol
        @won = won
    end

end
