// 게임 보드를 표현하는 열거형
enum Piece {
    case empty
    case x
    case o
}

// 게임 상태를 표현하는 프로토콜
protocol GameState {
    var currentPlayer: Piece { get }
    // [[Piece]] 는 타입별칭을 만들 수 있다.
    var board: [[Piece]] { get }
    func isValidMove(row: Int, column: Int) -> Bool
}

// 게임 로직을 담당하는 클래스
class TicTacToe: GameState {
    var board: [[Piece]]
    var currentPlayer: Piece
    
    init() {
        board = [[.empty, .empty, .empty],
                 [.empty, .empty, .empty],
                 [.empty, .empty, .empty]]
        currentPlayer = .x // x가 첫 번째 플레이어
    }
    
    func isValidMove(row: Int, column: Int) -> Bool {
        // TODO: isValidMove 메서드 구현
        if(board[row][column] != .empty){
            return false
        }
        else {
            return true
        }
    }
    
    func makeMove(row: Int, column: Int) -> Bool {
        // TODO: 플레이어 이동 메서드 구현
        if(!isValidMove(row: row, column: column)) {
            return false
        }
        else {
            board[row][column] = currentPlayer
            if(currentPlayer == .o) {
                currentPlayer = .x
            }
            else if (currentPlayer == .x) {
                currentPlayer = .o
            }
            return true
        }
    }
    
    func checkWinner() -> Piece? {
        // 이기는 경우의 수
        // 1. 가로줄 3
        // 2. 세로줄 3
        // 3. 대각 2
        
        for i in 0..<3 {
            // 가로
            if board[i][0] != .empty && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
                return board[i][0]
            }
            //세로
            if board[0][i] != .empty && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
                return board[0][i]
            }
        }
        
        // 대각선
        if board[0][0] != .empty && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            return board[0][0]
        }
        if board[0][2] != .empty && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            return board[0][2]
        }
        
        // 무승부
        // .empty칸이 있으면 진행중
        // .empty칸이 없으면 게임이 끝났음애도 승부가 안났으니 무승부
        
        for row in board {
            for col in row {
                if col == .empty {
                    return nil // 빈칸이 있으므로 진행중
                }
                
            }
        }
        return .empty // 무승부
        
    }
    
    func printBoard() {
        // 보드를 출력하는 코드
        print("---------\n")
        for row in board {
            var rowString = "|"
            for col in row {
                switch col {
                case .empty:
                    rowString += "   |" // 빈 칸
                case .x:
                    rowString += " X |" // X
                case .o:
                    rowString += " O |" // O
                }
            }
            print(rowString)
        }
    }
}

var game = TicTacToe()

while true {
    game.printBoard()
    print("\n현재 플레이어: \(game.currentPlayer)")
    
    print("행 입력 (0-2)('q' 입력시 종료): ", terminator: "")
    let rowInput = readLine() ?? ""
    if rowInput == "q" { break }
    
    guard let row = Int(rowInput) else { continue }
    if row > 2 {
        print("잘못된 숫자입니다. 다시 시도해주세요.")
        continue
    }
    
    print("열 입력 (0-2)('q' 입력시 종료): ", terminator: "")
    let colInput = readLine() ?? ""
    if colInput == "q" { break }
    
    guard let column = Int(colInput) else { continue }
    if column > 2 {
        print("잘못된 숫자입니다. 다시 시도해주세요.")
        continue
    }
    if !game.makeMove(row: row, column: column) {
        print("잘못된 위치입니다. 다시 시도해주세요.")
        continue
    }
    
    if let winner = game.checkWinner() {
        game.printBoard()
        if winner == .empty {
            print("무승부")
        } else {
            print("\(winner) 승리")
        }
        break
    }
}
