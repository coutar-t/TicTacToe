//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by Thibaut Coutard on 26/01/2022.
//

import Foundation

class TicTacToeViewModel: ObservableObject {

    let ticTacToe = TicTacToe()

    @Published var board: [[String]]
    var players: [Player]
    var currentPlayer: Int = 0

    init() {
        board = ticTacToe.getBoard()
        players = ticTacToe.players
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

}
