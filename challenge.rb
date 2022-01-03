require "./board.rb"

PIECE_SYMBOL = "  ♛"
NUMBER_OF_PIECES = 8
board = Board.new(NUMBER_OF_PIECES)
n = 0
i = 0
tmp = [];
while n < NUMBER_OF_PIECES do
    current_row = board.board[n]
    current_piece = current_row.find_index(PIECE_SYMBOL)

    available_spaces = if !current_piece.nil?
        board.remove_piece(n, current_piece, PIECE_SYMBOL)
        current_row.each_index.select{|i| i > current_piece && current_row[i] == Board::EMPTY_SPACE_VALUE}
    else
        current_row.each_index.select{|i| current_row[i] == Board::EMPTY_SPACE_VALUE}
    end

    i+=1
    break if i >= 1_000_000
    
    if available_spaces.empty?
        # board.show_board
        n
        n-=1
        next
    end
    
    available_space = available_spaces.shift
    board.add_piece n, available_space, PIECE_SYMBOL
    n+=1
end

board.show_board(true)
puts i
