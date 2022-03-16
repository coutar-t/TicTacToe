//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by Thibaut Coutard on 26/01/2022.
//

import Foundation

class TicTacToeViewModel: ObservableObject {

    private var ticTacToe: TicTacToe!

    @Published var board: [[String]]!
    @Published var gameStatus: String = ""
    @Published var showAlert: Bool = false
    var errorMessage: String = ""
    private var players: [Player]!
    private var currentPlayer: Int! {
        didSet {
            updateStatus()
        }
    }

    init() {
        ticTacToeSetup()
    }

    func didTapCase(x: Int, y: Int) {
        do {
            try ticTacToe.play(player: players[currentPlayer], coordinate: (x, y))
            currentPlayer = (currentPlayer + 1) % players.count
            board = ticTacToe.getBoard()
        } catch let e {
            showAlert = true

            errorMessage = getMessageFromError(e)
        }
    }

    func didTapResetGame() {
        ticTacToeSetup()
    }

    private func ticTacToeSetup() {
        ticTacToe = TicTacToe()
        board = ticTacToe.getBoard()
        players = ticTacToe.players
        currentPlayer = 0
    }
    
    private func updateStatus() {
        switch ticTacToe.state {
        case .playing:
            gameStatus = "Next Player : \(players[currentPlayer].mark)"
        case .tie:
            gameStatus = "Tie"
        case .won(let player):
            gameStatus = "Won by \(player.mark)"
        }
    }

    private func getMessageFromError(_ e: Error) -> String {
        if let tictactoeError = e as? TicTacToeError {
            switch tictactoeError {
            case .NotAPlayer:
                return "You are not a player"
            case .OutOfBounds:
                return "The play is out of bounds"
            case .AlreadyOccupied:
                return "The spot is already taken"
            case .NotPlayerTurn:
                return "This is not your turn"
            case .GameIsOver:
                return "The game is over"
            }
        } else {
            return e.localizedDescription
        }
    }
}
