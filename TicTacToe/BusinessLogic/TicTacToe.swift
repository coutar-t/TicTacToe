//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Thibaut Coutard on 15/12/2021.
//

import Foundation
/*
 Rules :
 - start a game
 - turn based
 - 3x3


 */

class TicTacToe {
    private let boardSize = (columns: 3, rows: 3)
    private var board: [[String]]
    private var nextPlayer: Player

    var players = [Player("X"), Player("O")]

    var state: GameState = .playing

    init() {
        self.board = Array(repeating: Array(repeating: "", count: boardSize.rows), count: boardSize.columns)
        self.nextPlayer = players[0]
    }

    private func checkIfPlayerHasWon(_ player: Player) -> Bool {
        for column in board {
            var playerHasWon = true
            for row in column {
                if row != player.mark {
                    playerHasWon = false
                }
            }
            if playerHasWon {
                return true
            }
        }

        for rowIndex in 0..<boardSize.rows {
            var playerHasWon = true
            for column in board {
                if column[rowIndex] != player.mark {
                    playerHasWon = false
                }
            }
            if playerHasWon {
                return true
            }
        }

        if board[0][0] == player.mark &&
            board[1][1] == player.mark &&
            board[2][2] == player.mark {
            return true
        }
        if board[0][2] == player.mark &&
            board[1][1] == player.mark &&
            board[2][0] == player.mark {
            return true
        }

        return false
    }

    private func checkIfIsValidPlay(play: (Int, Int)) -> Bool {
        (play.0 < board.count && play.1 < board[play.0].count)
    }

    private func updateNextPlayer() {
        nextPlayer = nextPlayer == players[0]
        ? players[1] : players[0]
    }

    func getBoard() -> [[String]] {
        board
    }

    func play(player: Player, coordinate: (Int, Int)) throws {
        guard players.contains(player) else { throw TicTacToeError.NotAPlayer }
        guard player == nextPlayer else { throw TicTacToeError.NotPlayerTurn }
        guard state == .playing else { throw TicTacToeError.GameIsOver }
        guard checkIfIsValidPlay(play: coordinate) else { throw TicTacToeError.OutOfBounds }
        guard board[coordinate.0][coordinate.1] == "" else { throw TicTacToeError.AlreadyOccupied }

        board[coordinate.0][coordinate.1] = player.mark


        if !board.flatMap({ $0 }).contains("") {
            state = .tie
        }

        if checkIfPlayerHasWon(player) {
            state = .won(player)
        }

        updateNextPlayer()
    }
}

enum TicTacToeError: Error {
    case NotAPlayer, OutOfBounds, AlreadyOccupied, NotPlayerTurn, GameIsOver
}

enum GameState: Equatable {
    case playing
    case won(Player)
    case tie
}

class Player: Equatable {
    var mark: String

    init(_ mark: String) {
        self.mark = mark
    }

    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs === rhs
    }
}

