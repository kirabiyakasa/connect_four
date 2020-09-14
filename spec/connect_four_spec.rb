require './interface.rb'
require './board.rb'

describe Board do
  describe "#update_board" do
    context "When color is white(●)." do
      it "Updates column when placing a black piece." do
        columns = subject.instance_variable_get(:@columns)
        subject.update_board("●", [3, 2])
        expect(columns[3]).to eql(
           [" ", " ", "●", " ", " ", " "],
          )
      end

      it "Returns false when not matching a line of 4 pieces." do
        subject.update_board("●", [0, 2])
        subject.update_board("●", [1, 3])
        expect(subject.update_board("●", [2, 4])).to eql(false)
      end

      it "Returns true when matching 4 diagonally." do
        subject.update_board("●", [0, 2])
        subject.update_board("●", [1, 3])
        subject.update_board("●", [2, 4])
        expect(subject.update_board("●", [3, 5])).to eql(true)
      end

      it "Returns true when matching 4 horizontally" do
        subject.update_board("●", [1, 3])
        subject.update_board("●", [2, 3])
        subject.update_board("●", [3, 3])
        expect(subject.update_board("●", [4, 3])).to eql(true)
      end

      it "Returns true when matching 4 vertically" do
        subject.update_board("●", [5, 2])
        subject.update_board("●", [5, 3])
        subject.update_board("●", [5, 4])
        expect(subject.update_board("●", [5, 5])).to eql(true)
      end
    end

    context "When color is black(○)" do
      it "Updates column when placing a white piece." do
        columns = subject.instance_variable_get(:@columns)
        subject.update_board("○", [2, 4])
        expect(columns[2]).to eql(
           [" ", " ", " ", " ", "○", " "],
          )
      end

      it "Returns false when not matching a line of 4 pieces." do
        subject.update_board("○", [4, 3])
        subject.update_board("○", [5, 4])
        expect(subject.update_board("○", [6, 5])).to eql(false)
      end

      it "Returns true when matching 4 diagonally." do
        subject.update_board("○", [4, 1])
        subject.update_board("○", [3, 2])
        subject.update_board("○", [2, 3])
        expect(subject.update_board("○", [1, 4])).to eql(true)
      end

      it "Returns true when matching 4 horizontally" do
        subject.update_board("○", [0, 0])
        subject.update_board("○", [1, 0])
        subject.update_board("○", [2, 0])
        expect(subject.update_board("○", [3, 0])).to eql(true)
      end

      it "Returns true when matching 4 vertically" do
        subject.update_board("○", [3, 1])
        subject.update_board("○", [3, 2])
        subject.update_board("○", [3, 3])
        expect(subject.update_board("○", [3, 4])).to eql(true)
      end
    end

  end
end

describe Interface do
  describe "#show_board" do

    it "Shows the board with spaces." do
      expect do
        board = Board.new
        names = ["Player 1", "Player 2"]
        colors = ["●", "○"]
        subject.show_board(board.columns, names, colors)
      end.to output(
            "\nPlayer 1: ●         0) Save Game\n"+
            "Player 2: ○\n\n"+
            "  1   2   3   4   5   6   7  \n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"
      ).to_stdout
    end

    it "Shows the board with white pieces." do
      expect do
        board = Board.new
        board.update_board("●", [3, 5])
        board.update_board("●", [3, 4])
        board.update_board("●", [2, 5])
        names = ["Player 1", "Player 2"]
        colors = ["●", "○"]
        subject.show_board(board.columns, names, colors)
      end.to output(
            "\nPlayer 1: ●         0) Save Game\n"+
            "Player 2: ○\n\n"+
            "  1   2   3   4   5   6   7  \n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   |   |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   |   | ● |   |   |   |\n"+
            "-----------------------------\n"+
            "|   |   | ● | ● |   |   |   |\n"+
            "-----------------------------\n"
      ).to_stdout
    end

      it "Shows the board with black pieces." do
        expect do
          board = Board.new
          board.update_board("○", [5, 5])
          board.update_board("○", [5, 4])
          board.update_board("○", [3, 5])
          board.update_board("○", [0, 5])
          names = ["Player 1", "Player 2"]
          colors = ["●", "○"]
          subject.show_board(board.columns, names, colors)
        end.to output(
              "\nPlayer 1: ●         0) Save Game\n"+
              "Player 2: ○\n\n"+
              "  1   2   3   4   5   6   7  \n"+
              "|   |   |   |   |   |   |   |\n"+
              "-----------------------------\n"+
              "|   |   |   |   |   |   |   |\n"+
              "-----------------------------\n"+
              "|   |   |   |   |   |   |   |\n"+
              "-----------------------------\n"+
              "|   |   |   |   |   |   |   |\n"+
              "-----------------------------\n"+
              "|   |   |   |   |   | ○ |   |\n"+
              "-----------------------------\n"+
              "| ○ |   |   | ○ |   | ○ |   |\n"+
              "-----------------------------\n"
        ).to_stdout
      end

  end
end
