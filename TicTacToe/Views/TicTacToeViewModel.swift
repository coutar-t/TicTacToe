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
    private var players: [Player]!
    private var currentPlayer: Int!

    init() {
        self.ticTacToeSetup()
    }

    func didTapCase(x: Int, y: Int) {
        do {
            try ticTacToe.play(player: players[currentPlayer], coordinate: (x, y))
            currentPlayer = (currentPlayer + 1) % players.count
            board = ticTacToe.getBoard()
        } catch let e {
            print(e.localizedDescription)
        }
    }

    func didTapResetGame() {
        self.ticTacToeSetup()
    }

    private func ticTacToeSetup() {
        ticTacToe = TicTacToe()
        board = ticTacToe.getBoard()
        players = ticTacToe.players
        currentPlayer = 0
    }

}
