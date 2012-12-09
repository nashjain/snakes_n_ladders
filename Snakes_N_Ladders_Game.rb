class Snakes_N_Ladders_Game
  def move(players, player_turn)
    new_position = players[player_turn] + throw_dice
    new_position = @snakes_ladders[new_position] if @snakes_ladders.has_key?(new_position)
    return player_turn if new_position >= @board_size 
    players[player_turn] = new_position
    next_player = (player_turn + 1) % players.length
    move(players, next_player)
  end

  def throw_dice
    1 + rand(6)
  end
  
  def random_board(no_of_snakes_ladders, board_size)
    snakes_ladders = {}
    no_of_snakes_ladders.times do
      snakes_ladders = snakes_ladders.merge(snake_or_ladder(board_size))
    end
    snakes_ladders
  end
  
  def snake_or_ladder(board_size)
    start = random_cell_value(board_size)
    ending = random_cell_value(board_size)
    return {start=>ending} unless start==ending
    snake_or_ladder(board_size) 
  end
  
  def random_cell_value(board_size)
    1 + rand(board_size - 1)
  end

  def initialize(players, mode=:Easy, board_size=100)
    @players = players
    @board_size = board_size
    game_modes = Hash.new(5).merge({:Easy=>5, :Medium=>10, :Hard=>20})
    @snakes_ladders = random_board(game_modes[mode], board_size)
  end
  
  def start
     players_starting_positions = @players.map{0}
     starting_player = rand(@players.length)
     winner = move(players_starting_positions, starting_player)
     puts "#{@players[winner]} won!"
  end
end

players = ["Ward", "Kent", "Ron"]
easy_game = Snakes_N_Ladders_Game.new(players)
easy_game.start
hard_game = Snakes_N_Ladders_Game.new(players, :Hard, 50)
hard_game.start