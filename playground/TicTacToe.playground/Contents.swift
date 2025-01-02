import Foundation

enum GridPosition: String {
    case empty = " "
    case player1 = "o"
    case player2 = "x"
}

struct TicTacToe {
    var gridStorage: [[GridPosition]] = []
    
    // 빈 3X3 게임판 만들기
    init () {
        for _ in 0..<3 {
            gridStorage.append(Array(repeating: .empty, count: 3)) // [.empty, .empty, .empty]
        }
    }
    
    subscript(row: Int, column: Int) -> GridPosition {
        get{
            return gridStorage[row][column]
        }
        set(newValue){
            gridStorage[row][column] = newValue
            print(newValue)
        }
        
    }
    
    func gameStateString() -> String {
        var stateString = "----------------\n"
        for row in gridStorage {
            stateString += printableString(forRow: row)
        }
        return stateString
    }
    
    func printableString(forRow row: [GridPosition]) -> String {
        var rowString = "|"
        for position in row {
            rowString += position.rawValue + "|"
            
        }
        return rowString + "\n"
        
    }
    
}

// Initialize the TicTacToe struct
var game = TicTacToe()
//game.gridStorage[1][1] = .player1
//game.gridStorage[0][2] = .player2

game[1, 1] = .player1
game[0, 2] = .player2

print(game.gameStateString())

