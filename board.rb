require "colorize"

class Board
    attr_accessor :board

    EMPTY_SPACE_VALUE = 0
    def initialize(number)
        @board ||= build_board(number)
    end

    def show_board(clean = false)
        board.each_with_index do |row, row_index|
            puts row.map {|v| (clean && v.is_a?(Numeric)) ? "   " : v }.each_with_index.map {|v, i| "#{v.to_s.colorize({color: :blue, background: (row_index + i).odd? ? :white : :default})}"}.join("")
        end
    end

    def add_piece(row, col, piece)
        if board[row][col] == EMPTY_SPACE_VALUE
            board[row][col] = piece
            project_move(row, col)
            return true
        end
        false
    end

    def remove_piece(row, col, piece)
        if board[row][col] == piece
            project_move(row, col, -1)
            board[row][col] = EMPTY_SPACE_VALUE
            return true
        end
        false
    end

    private
    def project_move(row, col, i=1)
        # Horizontal
        board[row].map! { |x| x.is_a?(Numeric)? x + i : x }
        # Vertical
        (0...board.size).each do |n|
            board[n][col]+=i if board[n][col].is_a?(Numeric)
        end
        # Diagonal
        row_a = row
        col_a = col
        while row_a >= 0 && col_a >= 0 do
            board[row_a][col_a]+=i if board[row_a][col_a].is_a?(Numeric)
            row_a-=1
            col_a-=1
        end

        row_a = row
        col_a = col
        while row_a >= 0 && col_a <= (board.size - 1) do
            board[row_a][col_a]+=i if board[row_a][col_a].is_a?(Numeric)
            row_a-=1
            col_a+=1
        end

        row_a = row
        col_a = col
        while row_a <= (board.size - 1) && col_a <= (board.size - 1) do
            board[row_a][col_a]+=i if board[row_a][col_a].is_a?(Numeric)
            row_a+=1
            col_a+=1
        end

        row_a = row
        col_a = col
        while row_a <= (board.size - 1) && col_a >= 0 do
            board[row_a][col_a]+=i if board[row_a][col_a].is_a?(Numeric)
            row_a+=1
            col_a-=1
        end
    end

    def build_board(number)
        arr = []
        number.times { |n| arr << (0...number).to_a.fill(0)}
        arr
    end
end