//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Thibaut Coutard on 15/12/2021.
//

import XCTest
@testable import TicTacToe

class TicTacToeTests: XCTestCase {
    func test_whenStartGame_thenReturnTheStartingGame() {
        // When

        let game = TicTacToe()

        // Then

        XCTAssertNotNil(game)
    }

    func test_whenGameStarts_thenInstantiateBoard() {
        // Given

        let game = TicTacToe()

        // When

        let board = game.getBoard()

        // Then

        XCTAssertEqual([["", "", ""], ["", "", ""], ["", "", ""]], board)
    }

    func test_whenPlayer1IsPlaying_thenAddAnX() {
        // Given

        let game = TicTacToe()

        // When

        try? game.play(player: game.players[0], coordinate: (0, 1))

        // Then

        let board = game.getBoard()
        XCTAssertEqual([["", "X", ""], ["", "", ""], ["", "", ""]], board)
    }

    func test_whenPlayer2IsPlaying_thenAddAO() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,0))
            .build()


        // When

        try? game.play(player: game.players[1], coordinate: (1, 0))

        // Then

        let board = game.getBoard()
        XCTAssertEqual([["X", "", ""], ["O", "", ""], ["", "", ""]], board)
    }

    func test_whenPlayerIs3_thenThrowAnError() {
        // Given

        let game = TicTacToe()

        // When

        do {
            try game.play(player: Player("U"), coordinate: (0,0))

            // Then

            XCTAssertTrue(false)
        } catch let error {
            XCTAssertEqual(TicTacToeError.NotAPlayer, error as? TicTacToeError)
        }
    }

    func test_whenCoordinatesIsOutOfBounds_thenThrowAnError() {
        // Given

        let game = TicTacToe()

        // When

        do {
            try game.play(player: game.players[0], coordinate: (3,0))

            // Then

            XCTAssertTrue(false)
        } catch let error {
            XCTAssertEqual(TicTacToeError.OutOfBounds, error as? TicTacToeError)
        }
    }

    func test_whenThreeOHorizontaly_thenPlayerTwoWins() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (1,0))
            .withPlaying(player: 2, coordinate: (0,0))
            .withPlaying(player: 1, coordinate: (1,1))
            .withPlaying(player: 2, coordinate: (0,1))
            .withPlaying(player: 1, coordinate: (2,0))
            .build()

        // When

        do {
            try game.play(player: game.players[1], coordinate: (0,2))

            // Then

            XCTAssertEqual(game.state, .won(game.players[1]))
        } catch {
            XCTFail()
        }
    }

    func test_whenThreeXHorizontaly_thenPlayerOneWins() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,0))
            .withPlaying(player: 2, coordinate: (1,0))
            .withPlaying(player: 1, coordinate: (0,1))
            .withPlaying(player: 2, coordinate: (1,1))
            .build()

        // When

        do {
            try game.play(player: game.players[0], coordinate: (0,2))

            // Then

            XCTAssertEqual(game.state, .won(game.players[0]))
        } catch {
            XCTFail()
        }
    }

    func test_whenThreeOVerticaly_thenPlayerTwoWins() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (1,2))
            .withPlaying(player: 2, coordinate: (0,0))
            .withPlaying(player: 1, coordinate: (0,1))
            .withPlaying(player: 2, coordinate: (1,0))
            .withPlaying(player: 1, coordinate: (0,2))
            .build()

        // When

        do {
            try game.play(player: game.players[1], coordinate: (2,0))

            // Then

            XCTAssertEqual(game.state, .won(game.players[1]))
        } catch {
            XCTFail()
        }
    }

    func test_whenThreeXVerticaly_thenPlayerOneWins() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,0))
            .withPlaying(player: 2, coordinate: (0,1))
            .withPlaying(player: 1, coordinate: (1,0))
            .withPlaying(player: 2, coordinate: (0,2))
            .build()

        // When

        do {
            try game.play(player: game.players[0], coordinate: (2,0))

            // Then

            XCTAssertEqual(game.state, .won(game.players[0]))
        } catch {
            XCTFail()
        }
    }

    func test_whenThreeXDiagonallyFromTopLeftCornerToBottomRightCorner_thenPlayerOneWins() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,0))
            .withPlaying(player: 2, coordinate: (0,1))
            .withPlaying(player: 1, coordinate: (1,1))
            .withPlaying(player: 2, coordinate: (0,2))
            .build()

        // When

        do {
            try game.play(player: game.players[0], coordinate: (2,2))

            // Then

            XCTAssertEqual(game.state, .won(game.players[0]))
        } catch {
            XCTFail()
        }
    }

    func test_whenThreeODiagonallyFromTopLeftCornerToBottomRightCorner_thenPlayerTwoWins() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,1))
            .withPlaying(player: 2, coordinate: (0,0))
            .withPlaying(player: 1, coordinate: (0,2))
            .withPlaying(player: 2, coordinate: (1,1))
            .withPlaying(player: 1, coordinate: (1,0))
            .build()

        // When

        do {
            try game.play(player: game.players[1], coordinate: (2,2))

            // Then

            XCTAssertEqual(game.state, .won(game.players[1]))
        } catch {
            XCTFail()
        }
    }

    func test_whenThreeXDiagonallyFromTopRightCornerToBottomLeftCorner_thenPlayerOneWins() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,2))
            .withPlaying(player: 2, coordinate: (0,1))
            .withPlaying(player: 1, coordinate: (1,1))
            .withPlaying(player: 2, coordinate: (1,2))
            .build()

        // When

        do {
            try game.play(player: game.players[0], coordinate: (2,0))

            // Then

            XCTAssertEqual(game.state, .won(game.players[0]))
        } catch {
            XCTFail()
        }
    }

    func test_whenThreeODiagonallyFromTopRightCornerToBottomLeftCorner_thenPlayerTwoWins() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,1))
            .withPlaying(player: 2, coordinate: (0,2))
            .withPlaying(player: 1, coordinate: (1,0))
            .withPlaying(player: 2, coordinate: (1,1))
            .withPlaying(player: 1, coordinate: (1,2))
            .build()

        // When

        do {
            try game.play(player: game.players[1], coordinate: (2,0))

            // Then

            XCTAssertEqual(game.state, .won(game.players[1]))
        } catch {
            XCTFail()
        }
    }

    func test_whenGameHasNoMorePlacesAndNoOneWins_thenStateIsTie() {
        // Given/When

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (2,2))
            .withPlaying(player: 2, coordinate: (0,0))
            .withPlaying(player: 1, coordinate: (0,1))
            .withPlaying(player: 2, coordinate: (0,2))
            .withPlaying(player: 1, coordinate: (1,0))
            .withPlaying(player: 2, coordinate: (1,1))
            .withPlaying(player: 1, coordinate: (1,2))
            .withPlaying(player: 2, coordinate: (2,1))
            .withPlaying(player: 1, coordinate: (2,0))

            .build()

            // Then

            XCTAssertEqual(game.state, .tie)
    }

    func test_whenGameIsNotOver_thenStateIsPlaying() {
        // Given / When

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,0))
            .build()

        // Then

        XCTAssertEqual(game.state, .playing)
    }

    func test_givenCellIsOccupied_whenPlayerTryToPlayOnIt_thenThrowAnError() {
        // Given / When

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,0))
            .build()

        // When

        do {
            try game.play(player: game.players[1], coordinate: (0, 0))

            // Then

            XCTFail()
        } catch let error {
            XCTAssertEqual(TicTacToeError.AlreadyOccupied, error as? TicTacToeError)
        }
    }

    func test_givenPlayerOneHasPlayed_whenPlayerOnePlayAgain_thenThrowAnError() {
        // Given

        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,0))
            .build()

        // When

        do {
            try game.play(player: game.players[0], coordinate: (0, 1))

            // Then

            XCTFail()
        } catch let error {
            XCTAssertEqual(TicTacToeError.NotPlayerTurn, error as? TicTacToeError)
        }
    }

    func test_givenPlayerOneHasWon_whenPlayerTwoPlay_thenThrowAnError() {
        let game = TicTacToeBuilder()
            .withPlaying(player: 1, coordinate: (0,1))
            .withPlaying(player: 2, coordinate: (1,1))
            .withPlaying(player: 1, coordinate: (0,2))
            .withPlaying(player: 2, coordinate: (1,2))
            .withPlaying(player: 1, coordinate: (0,0))
            .build()

        do {
            try game.play(player: game.players[1], coordinate: (2, 1))

            // Then

            XCTFail()
        } catch let error {
            XCTAssertEqual(TicTacToeError.GameIsOver, error as? TicTacToeError)
        }
    }
}

class TicTacToeBuilder {
    private var plays: [(player: Int, coordinate: (Int, Int))] = []

    func withPlaying(player: Int, coordinate: (Int, Int)) -> Self {
        self.plays.append((player: player, coordinate: coordinate))
        return self
    }

    func build() -> TicTacToe {
        let game = TicTacToe()
        do {
            for play in plays {
                let player = game.players[play.player - 1]
                try game.play(player: player, coordinate: play.coordinate)
            }
        } catch {
            XCTFail()
        }
        return game
    }
}
