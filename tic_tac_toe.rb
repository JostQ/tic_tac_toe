#On appelle les fichiers contenant nos classes, nos méthodes
require_relative "src/Board.rb"
require_relative "src/BoardCase.rb"
require_relative "src/Game.rb"
require_relative "src/Player.rb"
#On oublie pas l'arc en ciel pour mettre de la couleur dans nos vies
require 'rainbow'
#Et on lance le jeu ! \o/ (voir méthode start_game pour la suite)
Game.new.start_game