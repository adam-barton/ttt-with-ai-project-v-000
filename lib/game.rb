class Game

  WIN_COMBINATIONS = [
   [0, 1, 2],
   [3, 4, 5],
   [6, 7, 8],
   [0, 3, 6],
   [1, 4, 7],
   [2, 5, 8],
   [0, 4, 8],
   [2, 4, 6]
  ]


  attr_reader :player_1, :player_2, :board

   def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
     @player_1 = player_1
     @player_2 = player_2
     @board = board
  end

  def one_player_game
    one_player = Game.new(player_1 = Players:: Human.new("X"), player_2 = Players::Computer.new("O"), board = Board.new)
    one_player.play
  end

  def no_player_game
    no_players = Game.new(player_1 = Players::Computer.new("X"), player_2 = Players::Computer.new("O"), board = Board.new)
    no_plyers.play
  end

  def player_1=(player_1)
    @player_1 = player_1
  end

  def player_2=(player_2)
    @player_2 = player_2
  end

  def board=(board)
    @board = board
  end

  def turn_count
    board.cells.count {|space| space != " "}
  end

  def current_player
    turn_count % 2 == 0 ? @player_1 : @player_2
  end

  def full?
    board.cells.all? do|space|
     space == "X" || space == "O"
   end
  end

  def won?
    WIN_COMBINATIONS.detect do |winner|


     board.cells[winner[0]] == board.cells[winner[1]] && 
     board.cells[winner[1]] == board.cells[winner[2]] &&
     (board.cells[winner[0]] == "X" || board.cells[winner[0]] == "O")
    end
  end
  #    board.cells[win_index[1]]
  #    board.cells[win_index[2]]
  # 
  #    position_1 == "X" && position_2 == "X" && position_3 == "X" ||
  #    position_1 == "O" && position_2 == "O" && position_3 == "O"
  #  end
  # end

  def draw?
    !won?  &&  full?
  end

  def over?
    draw? || won?
  end

  def winner
    won? && board.cells[won?[0]]
  end

  def turn
    this_move = current_player.move(current_player.token)
    if  board.valid_move?(this_move)
         board.update(this_move, current_player)
     board.display
      else
       puts "Try again."
       turn
    end
  end

  def play
    turn until over?
    if winner
      puts "Congratulations #{winner}!"
    elsif
      draw?
        puts "Cat's Game!"
    end
  end

  def game_type
    selection = STDIN.gets.strip
    until selection == "1" || "2" || "3"
      puts "Please enter 1, 2 or 3."
    end
      case selection
      when "1"
        one_player_game
      when "2"
        game_1 = Game.new
        game_1.play
      when "3"
        no_player_game
    end
  end

end
